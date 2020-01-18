class Pplite < Formula
  desc 'PPLite is an open-source C++ library implementing the abstract domain of convex polyhedra, to be used in tools for static analysis and verification.'
  homepage 'http://www.cs.unipr.it/~zaffanella/PPLite/PPLite.html'
  url 'http://www.cs.unipr.it/~zaffanella/PPLite/releases/pplite-0.5.1.tar.gz'
  version '0.5.1'
  sha256 '028e68d8fa406dfcd78d259fa6612fabd4163c9615de689ab8c12016c9dd81b9'
  depends_on 'flint' => :build

  def install
    system './configure', "--prefix=#{prefix}"
    system 'make'
    system 'make', 'install'
  end

  test do
    system "#{bin}/phaverlite", '-v'
  end
end

