class LtsminBeta < Formula
  desc "High-performance, language-independent model checker (beta channel)"
  homepage "https://github.com/utwente-fmt/ltsmin"
  url "https://github.com/Meijuh/ltsmin.git",
      tag: "v3.1.0-beta2",
      revision: "192741920901544c079194105a34db0bc95ab00a"
  license "BSD-3-Clause"
  head "https://github.com/Meijuh/ltsmin.git"

  # Add ltl2ba as a resource
  resource "ltl2ba" do
    url "https://github.com/utwente-fmt/ltl2ba.git", branch: "master"
  end

  # Build tooling
  depends_on "pkg-config" => :build
  # Autotools needed because tarball lacks pre-generated configure
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool"  => :build
  # LTSmin requires GNU make (Apple's BSD make can fail on some targets)
  depends_on "make" => :build
  # Bison 3.0.2+ is required for parsing
  depends_on "bison" => :build
  depends_on "ant" => :build

  # Required runtime deps
  depends_on "popt"
  depends_on "zlib"

  # Optional frontends/features
  depends_on "spot" => :recommended   # LTL/ω-automata (Büchi) integration
  depends_on "libxml2" => :optional   # PNML frontend
  # Distributed tools are disabled in this formula

  # Sylvan and others are optional; users can add them separately if desired.

  def install
    # Check if running on ARM and fail with a clear message
    if Hardware::CPU.arm?
      odie "LTSmin is not compatible with ARM processors. Installation aborted."
    end
    # Extract ltl2ba resource to replace the bundled version
    resource("ltl2ba").stage do
      rm_rf buildpath/"ltl2ba"
      cp_r ".", buildpath/"ltl2ba"
    end

    # Use the original ltsminreconf script which properly handles ltl2ba
    system "./ltsminreconf"

    # Make some variables extern to avoid link errors
    system "sed", "-i", "''", 's/^ltsmin_expr_t/extern ltsmin_expr_t/;s/^ltsmin_parse_env_t/extern ltsmin_parse_env_t/;', "./src/pins2lts-sym/aux/options.h"

    # Create git_version.h file
    mkdir_p "src/hre"
    (buildpath/"src/hre/git_version.h").write(<<~EOS)
      #ifndef GIT_VERSION
      #define GIT_VERSION "#{version}"
      #endif
    EOS

    # Fix MPI compatibility issue
    inreplace "src/hre-mpi/hre_mpi.c",
              "MPI_Errhandler_set(MPI_COMM_WORLD,MPI_ERRORS_ARE_FATAL);",
              "MPI_Comm_set_errhandler(MPI_COMM_WORLD,MPI_ERRORS_ARE_FATAL);"

    # Set C++17 standard for the compiler
    ENV.append "CXXFLAGS", "-std=c++17"

    # Configure with appropriate flags
    args = std_configure_args

    # Add optional dependencies
    args << "--with-spot=#{Formula["spot"].opt_prefix}" if build.with? "spot"
    args << "--with-libxml2=#{Formula["libxml2"].opt_prefix}" if build.with? "libxml2"

    # Disable distributed tools and enable only core components
    args << "--disable-mpi"
    args << "--disable-all-mpi"
    args << "--disable-all-dist"
    

    system "./configure", *args

    # Build and install (use gmake from Homebrew)
    system Formula["make"].opt_bin/"gmake"
    system Formula["make"].opt_bin/"gmake", "install"
    
  end

  test do
    # Print help of a core tool to ensure binaries link & run
    assert_match "usage", shell_output("#{bin}/pins2lts-seq --help")
  end

  livecheck do
    skip "Pinned to a specific beta release"
  end
end
