# coding: utf-8
class Spot < Formula
  desc 'Platform for LTL and ω-automata manipulation'
  homepage 'https://spot.lrde.epita.fr/'
  url 'http://www.lrde.epita.fr/dload/spot/spot-2.9.6.tar.gz'
  version '2.9.6'
  sha256 '3cc6f69f17f0d1566d68be7040099df70203748b66121354d8ab84d8d13dd3a8'

  def install
    system './configure', "--prefix=#{prefix}"
    system 'make'
    system 'make', 'install'
  end

  test do
    system "#{bin}/genaut", '-v'
  end
end
