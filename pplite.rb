class Pplite < Formula
  desc "C++ library implementing the abstract domain of convex polyhedra"
  homepage "https://www.cs.unipr.it/~zaffanella/PPLite/PPLite.html"
  url "https://www.cs.unipr.it/~zaffanella/PPLite/releases/pplite-0.7.tar.gz"
  sha256 "66f5a3371fa6e91d93713f3f4eb31e1d07cc3742826565d93fff41326ffaa3cb"
  depends_on "flint" => :build

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
   (testpath/"test.c").write <<~EOS
      #include <mxml.h>

      int main()
      {
        FILE *fp;
        mxml_node_t *tree;
        mxml_node_t *tree;

        fp = fopen("test.xml", "r");
        tree = mxmlLoadFile(NULL, fp, MXML_OPAQUE_CALLBACK);
        fclose(fp);
      }
    EOS

    (testpath/"test.xml").write <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <test>
        <text>I'm an XML document.</text>
      </test>
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lmxml", "-o", "test"
    system "./test"
  end
end
