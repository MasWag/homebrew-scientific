class TreeSitterSymon < Formula
  desc "Tree-sitter grammer for SyMon"
  homepage "https://github.com/MasWag/tree-sitter-symon"
  version "0.1.0"
  license "MIT"
  head "https://github.com/MasWag/tree-sitter-symon.git", branch: "master"

  depends_on "cmake" => :build

  def install
    system "cmake", "-B", "build", "-S", ".", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_predicate include/"tree_sitter/tree-sitter-symon.h", :exist?
  end
end
