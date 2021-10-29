# typed: false
# frozen_string_literal: true

class Spot < Formula
  desc "Platform for LTL and omega-automata manipulation"
  homepage "https://spot.lrde.epita.fr/"
  url "http://www.lrde.epita.fr/dload/spot/spot-2.9.8.tar.gz"
  sha256 "b7f404bb90a335a5914384ecc3fc3a2021ff22c57ee97a40c07bb2ab40e20cf9"
  license "GPL-3.0"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    `#{bin}/genaut --version`.include?(version)
  end
end
