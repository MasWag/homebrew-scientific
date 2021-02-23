class Monaa < Formula
  desc 'Tool for timed patten matching with automata-based acceleration'
  homepage 'https://github.com/MasWag/monaa'
  url 'https://github.com/MasWag/monaa/archive/0.5.1.zip'
  version '0.5.1'
  head 'https://github.com/MasWag/monaa.git'
  sha256 'cb9331d63bfd38d386c68222c187bc6243685d364392af99cf59c8aa33f4847a'
  depends_on 'cmake' => :build
  depends_on 'boost' => :build
  depends_on 'eigen' => :build
  depends_on 'bison' => :build
  depends_on 'flex' => :build

  def install
    mkdir_p 'build'
    chdir 'build'
    system 'cmake', '..', '-DCMAKE_BUILD_TYPE=Release', "-DCMAKE_INSTALL_PREFIX=#{prefix}", *std_cmake_args
    system "make", "monaa", "tre2ta"
    system "make", "install"
    system "install" "-m755" "tre2ta" "#{prefix}/bin"
    if File.exist? '../doc/monaa.1' then
      mkdir_p "#{prefix}/share/man/man1/"
      system 'install', '../doc/monaa.1', "#{prefix}/share/man/man1/"
    end
    if File.exist? "../doc/tre2ta.1" then
      mkdir_p "#{prefix}/share/man/man1/"
      system "install" "-m644" "../doc/tre2ta.1" "#{prefix}/share/man/man1/"
    end
  end

  test do
    system "#{bin}/monaa", "-v"
  end
end

