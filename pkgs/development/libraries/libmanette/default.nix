{ stdenv
, fetchurl
, ninja
, meson
, pkgconfig
, vala
, gobject-introspection
, glib
, libgudev
, libevdev
, gnome3
}:

stdenv.mkDerivation rec {
  pname = "libmanette";
  version = "0.2.4";

  outputs = [ "out" "dev" ];

  src = fetchurl {
    url = "mirror://gnome/sources/${pname}/${stdenv.lib.versions.majorMinor version}/${pname}-${version}.tar.xz";
    sha256 = "1xrc6rh73v5w3kbkflzv1yg8sbxk4wf06hfk95raxhxlssza9q2g";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkgconfig
    vala
    gobject-introspection
  ];

  buildInputs = [
    glib
    libgudev
    libevdev
  ];

  doCheck = true;

  passthru = {
    updateScript = gnome3.updateScript {
      packageName = pname;
    };
  };

  meta = with stdenv.lib; {
    description = "A simple GObject game controller library";
    homepage = "https://gitlab.gnome.org/aplazas/libmanette";
    license = licenses.lgpl21Plus;
    maintainers = teams.gnome.members;
    platforms = platforms.unix;
  };
}
