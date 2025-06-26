# typed: false
# frozen_string_literal: true

class Tchecker < Formula
  desc "Open-source verification tool for timed automata"
  homepage "https://github.com/ticktac-project/tchecker"
  url "https://github.com/ticktac-project/tchecker/archive/refs/tags/v0.8.tar.gz"
  sha256 "3a2ed981c5f63d8d4587d07a1c8467626bff0714f1ed089cd8d37c19a649e75d"
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
