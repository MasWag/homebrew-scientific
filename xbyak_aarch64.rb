class XbyakAarch64 < Formula
  desc "JIT assembler for AArch64 CPUs by C++"
  homepage "https://github.com/fujitsu/xbyak_aarch64"
  url "https://github.com/fujitsu/xbyak_aarch64/archive/refs/tags/v1.1.2.tar.gz"
  sha256 "baeaec9a193800f79728db910fd3397f6d9db381f26d8cdf35a972b43e7a8d5a"
  license "Apache-2.0"

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    # Check if 'libxbyak_aarch64.a' exists
    lib_path = lib/"libxbyak_aarch64.a"
    assert_predicate lib_path, :exist?, "libxbyak_aarch64.a does not exist in #{lib}"

    # Check if 'xbyak_aarch64.h' exists
    include_path = include/"xbyak_aarch64/xbyak_aarch64.h"
    assert_predicate include_path, :exist?, "xbyak_aarch64.h does not exist in #{include}"
  end
end
