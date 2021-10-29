# typed: false
# frozen_string_literal: true

class Phaverlite < Formula
  desc "PHAVerLite (PHAVer + PPLite) is a variant of PHAVer, a formal verification tool for computing reachability of hybrid systems."
  homepage "http://www.cs.unipr.it/~zaffanella/PPLite/PHAVerLite"
  url "http://www.cs.unipr.it/~zaffanella/PPLite/releases/phaverlite-0.4.tar.gz"
  sha256 "6b9de4713cb8b84fdd84d453532be2d6d8653c77b373d58f15e8401bb0603986"
  depends_on "pplite" => :build

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    "PHAVerLite 0.4: starting\n" == `#{bin}/phaverlite -version`
  end
end

