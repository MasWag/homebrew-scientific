# typed: false
# frozen_string_literal: true

class Phaverlite < Formula
  desc "PHAVerLite (PHAVer + PPLite) is a variant of PHAVer, a formal verification tool for computing reachability of hybrid systems."
  homepage "https://github.com/ezaffanella/PHAVerLite"
  url "https://github.com/ezaffanella/PHAVerLite/raw/main/releases/phaverlite-0.6.tar.gz"
  sha256 "875e4e505987b37fede9e9bebdbf3d9cc3243727cd22f60ce93facb6b4763aa1"
  depends_on "pplite" => :build

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    "PHAVerLite 0.6: starting\n" == `#{bin}/phaverlite -version`
  end
end

