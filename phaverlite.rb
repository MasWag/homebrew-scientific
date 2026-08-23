# typed: false
# frozen_string_literal: true

class Phaverlite < Formula
  desc "PHAVerLite (PHAVer + PPLite) is a variant of PHAVer, a formal verification tool for computing reachability of hybrid systems."
  homepage "https://github.com/ezaffanella/PHAVerLite"
  url "https://github.com/ezaffanella/PHAVerLite/raw/main/releases/phaverlite-0.8.tar.gz"
  sha256 "3a54705f38c56386557c2151c707e572f88b985afbc72ed9df5d384368ed6c5d"
  depends_on "pplite" => :build

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    assert_equal "PHAVerLite 0.8: starting\n", `#{bin}/phaverlite -version`
  end
end

