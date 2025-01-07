# typed: false
# frozen_string_literal: true

class Phaverlite < Formula
  desc "PHAVerLite (PHAVer + PPLite) is a variant of PHAVer, a formal verification tool for computing reachability of hybrid systems."
  homepage "https://github.com/ezaffanella/PHAVerLite"
  url "https://github.com/ezaffanella/PHAVerLite/raw/main/releases/phaverlite-0.7.tar.gz"
  sha256 "4de2a80b11852b99590b35e3a8601b58c2612854585d5ca70ace82adf4026bb0"
  depends_on "pplite" => :build

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    assert_equal "PHAVerLite 0.7: starting\n", `#{bin}/phaverlite -version`
  end
end

