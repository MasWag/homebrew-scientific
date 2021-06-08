# typed: false
# frozen_string_literal: true

class Tchecker < Formula
  desc "Open-source verification tool for timed automata"
  homepage "https://github.com/ticktac-project/tchecker"
  url "https://github.com/ticktac-project/tchecker/archive/refs/tags/v0.2.tar.gz"
  sha256 "a638016de673f003280b2c23185cf007992fd09e8e785779d5eeee30e52ace6b"
  license "MIT"
  head "https://github.com/ticktac-project/tchecker.git"
  depends_on "bison" => :build
  depends_on "boost" => :build
  depends_on "cmake" => :build
  depends_on "flex" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "make", "-C", "build"
    system "make", "-C", "build", "install"
  end

  test do
    system "#{bin}/tchecker", "--help"
  end
end
