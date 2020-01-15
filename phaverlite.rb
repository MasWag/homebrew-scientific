class Phaverlite < Formula
  desc 'PHAVerLite (PHAVer + PPLite) is a variant of PHAVer, a formal verification tool for computing reachability of hybrid systems.'
  homepage 'http://www.cs.unipr.it/~zaffanella/PPLite/PHAVerLite'
  url 'http://www.cs.unipr.it/~zaffanella/PPLite/releases/phaverlite-0.2.1.tar.gz'
  version '0.2.1'
  sha256 '5d8f30909f4a0986c000196cee436f0c9ce14e5e02f62d4b5d3445f5712b9024'
  depends_on 'pplite' => :build

  patch do
    url 'https://gist.githubusercontent.com/MasWag/5404ed4869db23a9897f8e4f05151742/raw/1ef3c71c807196bb58feb28f8f2340ebaf439dde/gistfile1.txt'
    sha256 '73218d421a07a1a436de1b945394493d894b6c702ba8e148ac4ccbb569c5f440'
  end

  def install
    system './configure', "--prefix=#{prefix}"
    system 'make'
    system 'make', 'install'
  end

  test do
    system "#{bin}/phaverlite", '-v'
  end
end

