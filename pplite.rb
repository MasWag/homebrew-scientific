class Pplite < Formula
  desc "C++ library implementing the abstract domain of convex polyhedra"
  homepage "https://github.com/ezaffanella/PPLite"
  url "https://github.com/ezaffanella/PPLite/raw/main/releases/pplite-0.14.tar.gz"
  sha256 "828eae453ed0abc14fd2e46dc0a2796d6cb04b897499251e9eca24d9e8ec1273"
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
