class Monaa < Formula
  desc "Tool for timed patten matching with automata-based acceleration"
  homepage "https://github.com/MasWag/monaa"
  url "https://github.com/MasWag/monaa/archive/0.5.4.zip"
  version "0.5.4"
  head "https://github.com/MasWag/monaa.git"
  sha256 "4aac822e21fc6803fbdd2f0d34cb09e21028afa739a0be74264d093ec3ca594f"
  depends_on "cmake" => :build
  depends_on "boost" => :build
  depends_on "eigen" => :build
  depends_on "bison" => :build
  depends_on "flex" => :build

  def install
    mkdir_p "build"
    chdir "build"
    system "cmake", "..", "-DCMAKE_BUILD_TYPE=Release", "-DCMAKE_INSTALL_PREFIX=#{prefix}", *std_cmake_args
    system "make", "monaa", "tre2ta"
    system "make", "install"
    system "install", "-m755", "tre2ta", "#{prefix}/bin"
    if File.exist? '../doc/monaa.1' then
      mkdir_p "#{prefix}/share/man/man1/"
      system "install", "../doc/monaa.1", "#{prefix}/share/man/man1/"
    end
    if File.exist? "../doc/tre2ta.1" then
      mkdir_p "#{prefix}/share/man/man1/"
      system "install", "-m644", "../doc/tre2ta.1", "#{prefix}/share/man/man1/"
    end
  end

  test do
    system "#{bin}/monaa", "-V"
  end
end

