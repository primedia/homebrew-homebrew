require "formula"

class Rpenv < Formula
  PACKAGE = "github.com/rentpath/rpenv"

  homepage "https://#{PACKAGE}"
  url "https://#{PACKAGE}/archive/v3.1.1.tar.gz"
  sha256 "d4dc11a0e2b2dceb42d8480b5d58c45ee6a8ababc73ca569fdb67a0876bd18f7"
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
