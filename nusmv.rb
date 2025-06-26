# typed: false
# frozen_string_literal: true

class Nusmv < Formula
  desc "A new symbolic model checker"
  homepage "http://nusmv.fbk.eu"
  url "https://nusmv.fbk.eu/distrib/2.7.0/NuSMV-2.7.0.tar.xz"
  sha256 "bf5b14c4e2ca1f5e8404c8ce75825183d8f5842063cb1e58e073d92bb1234828"
  license "LGPLv2.1"
  depends_on "meson" => :build
  depends_on "ninja" => :build

  def install
    inreplace "meson.build", "find_program('python')", "find_program('python3')"
    inreplace "scripts/meson-util.py", "/usr/bin/env python", "/usr/bin/env python3"
    # We cannot use *std_meson_args because we need to use cudd from the fallback
    system "meson", "setup", "build", "--prefix=#{prefix}", "--libdir=#{lib}", "--buildtype=release", "-Dbuild-doc=disabled"
    system "meson", "compile", "-C", "build"
    system "meson", "install", "-C", "build"
  end

  test do
    system "#{bin}/nusmv", "--help"
  end
end
