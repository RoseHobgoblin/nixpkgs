{ stdenv, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  pname = "rclone";
  version = "1.50.2";

  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = "v${version}";
    sha256 = "0yaspkh88q8i58i8g8mm6sqb75hczavz2lvzdd1iif1bqgi6b5fz";
  };

  goPackagePath = "github.com/rclone/rclone";

  subPackages = [ "." ];

  outputs = [ "bin" "out" "man" ];

  postInstall = ''
    install -D -m644 $src/rclone.1 $man/share/man/man1/rclone.1
  '';

  meta = with stdenv.lib; {
    description = "Command line program to sync files and directories to and from major cloud storage";
    homepage = https://rclone.org;
    license = licenses.mit;
    maintainers = with maintainers; [ danielfullmer ];
    platforms = platforms.all;
  };
}
