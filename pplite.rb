class Pplite < Formula
  desc "C++ library implementing the abstract domain of convex polyhedra"
  homepage "https://github.com/ezaffanella/PPLite"
  url "https://github.com/ezaffanella/PPLite/raw/main/releases/pplite-0.10.2.tar.gz"
  sha256 "18f34817e5fb10e11931a587bc4466d5a459a8ce8abe0d17404ad41cb7a27fa8"
  depends_on "flint" => :build
  depends_on "libmxml" => :test

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
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-L/usr/local/lib", "-L/opt/homebrew/lib", "-lmxml", "-o", "test"
    system "./test"
  end
end
