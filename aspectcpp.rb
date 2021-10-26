class Aspectcpp < Formula
  desc "Aspect-oriented programming for C++"
  homepage "https://www.aspectc.org/"
  # url "https://www.aspectc.org/releases/2.3/ac-2.3.tar.gz"
  url "https://www.aspectc.org/releases/2.3/ac-bin-macosx-x86-64bit-2.3.tar.gz"
  sha256 "03d70e1e73bdf198f4e4606c28f61502f6e95df928fd971b0888d7dfebca9c43"
  license "GPL-2.0-or-later"
  # head "https://www.aspectc.org/daily/aspectcpp-source-daily.tar.gz"
  head "https://www.aspectc.org/daily/aspectcpp-macosx64-daily.tar.gz"

  def install
    mkdir_p "#{bin}/"
    FileUtils.install "ac++", "#{bin}/"
    FileUtils.install "ag++", "#{bin}/"
    mkdir_p "#{share}/aspectcpp/"
    cp_r "./examples", "#{share}/aspectcpp/"
  end

  test do
    chdir "#{share}/aspectcpp/examples/helloworld"
    system "#{bin}/ag++", "-x", "c++", "-c", "#{share}/aspectcpp/examples/helloworld/main.cc", "-o", "/tmp/helloworld.o"
    system "c++", "/tmp/helloworld.o", "-o", "/tmp/helloworld"
    puts(`/tmp/helloworld`)
    `/tmp/helloworld` == "Hello\nWorld\n"
  end
end
