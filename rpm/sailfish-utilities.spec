%bcond_with l10n

Summary: Sailfish Utilities
Name: sailfish-utilities
Version: 0.0.0
Release: 1
License: LGPLv2.1
URL: https://github.com/sailfishos/sailfish-utilities
Source0: %{name}-%{version}.tar.bz2
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-buildroot
Requires:  sailfishsilica-qt5
Requires: jolla-settings-system >= 0.1.69
Requires: nemo-qml-plugin-notifications-qt5
Requires: nemo-qml-plugin-devicelock
Requires: nemo-qml-plugin-dbus-qt5
Requires:  mapplauncherd-booster-silica-qt5
Requires: tracker >= 1.3.2
BuildRequires: cmake >= 2.8
BuildRequires: qt5-default
BuildRequires: qt5-qttools
BuildRequires: qt5-qttools-linguist
BuildRequires: pkgconfig(Qt5Core)
BuildRequires: pkgconfig(Qt5Qml)
BuildRequires: pkgconfig(Qt5Quick)
BuildRequires: pkgconfig(Qt5Gui)
BuildRequires: systemd
%if %{with l10n}
BuildRequires: %{name}-all-translations-pack
%define _all_translations_version %(rpm -q --queryformat "%%{version}-%%{release}" %{name}-all-translations-pack)
Requires: %{name}-all-translations-pack >= %{_all_translations_version}
%endif

%description
Miscellaneous Sailfish Utilities

%package ts-devel
Summary: Translation source for %{name}
%description ts-devel
Translation source for %{name}

%prep
%setup -q

%build
%cmake
make %{?jobs:-j%jobs}

%install
rm -rf %{buildroot}
make install DESTDIR=%{buildroot}

%clean
rm -rf %{buildroot}

%files
%defattr(-,root,root,-)
%attr(4754, root, privileged) %{_bindir}/sailfish_tools_system_action
%dir %{_datadir}/sailfish-utilities
%{_datadir}/sailfish-utilities/*.qml
%{_datadir}/sailfish-utilities/*.sh
%dir %{_datadir}/sailfish-utilities/plugins
%{_datadir}/sailfish-utilities/plugins/*.qml
%{_datadir}/jolla-settings/entries/utilities.json
%{_datadir}/translations/settings-sailfish_utilities_eng_en.qm
%dir %{_libdir}/qt5/qml/Sailfish/Utilities
%{_libdir}/qt5/qml/Sailfish/Utilities/*

%files ts-devel
%defattr(-,root,root,-)
%{_datadir}/translations/source/settings-sailfish_utilities.ts
