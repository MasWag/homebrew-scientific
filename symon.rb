class Symon < Formula
  desc "A tool for SYmbolic MONitoring"
  homepage "https://github.com/MasWag/symon"
  version "0.1.0"
  license "MIT"
  head "https://github.com/MasWag/symon.git"

  depends_on "boost"
  depends_on "cmake" => :build
  depends_on "ppl"
  depends_on "tree-sitter"
  depends_on "tree-sitter-symon"

  def install
    system "cmake", "-B", "build", "-S", ".", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    # Run symon
    system bin/"symon", "--version"
  end
end
