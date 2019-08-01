class Monaa < Formula
  desc 'Tool for timed patten matching with automata-based acceleration'
  homepage 'https://github.com/MasWag/monaa'
  url 'https://github.com/MasWag/monaa/archive/0.4.1.zip'
  version '0.4.1'
  head 'https://github.com/MasWag/monaa.git'
  sha256 'f41b86c826d007dee15407198d1304cc93ee891987be1bfa8a1ef543e3e2a615'
  depends_on 'cmake' => :build
  depends_on 'boost' => :build
  depends_on 'eigen' => :build
  depends_on 'bison' => :build
  depends_on 'flex' => :build

  def install
    mkdir_p 'build'
    chdir 'build'
    system 'cmake', '..', '-DCMAKE_BUILD_TYPE=Release', "-DCMAKE_INSTALL_PREFIX=#{prefix}", *std_cmake_args
    system 'make', 'monaa'
    system 'make', 'install'
    if File.exist? '../doc/monaa.1' then
      mkdir_p "#{prefix}/share/man/man1/"
      system 'install', '../doc/monaa.1', "#{prefix}/share/man/man1/"
    end
  end

  test do
    system "#{bin}/monaa", "-v"
  end
end

