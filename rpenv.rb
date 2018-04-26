require "formula"

class Rpenv < Formula
  PACKAGE = "github.com/rentpath/rpenv"

  homepage "https://#{PACKAGE}"
  url "https://#{PACKAGE}/archive/v3.1.2.tar.gz"
  sha256 "974c5cb402274824f413a8889bb6fc5c25c6c0840f26652e6d084f1985837aa2"
  head "https://#{PACKAGE}.git"

  depends_on "go" => :build

  def install
    (buildpath/"src/#{PACKAGE}").install Dir["./*"]

    ENV["GOPATH"] = buildpath

    system "go", "build", "-o", "rpenv", PACKAGE
    bin.install "rpenv"

    ohai "be sure to add a ~/.config/.rpenv file containing ci, qa, "
    ohai "and prod urls per the README of https://#{PACKAGE}."
  end

  test do
    `#{bin}/rpenv`
    assert_equal $?.to_i, 1
  end
end
