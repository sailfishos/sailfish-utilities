Summary: Sailfish Utilities
Name: sailfish-utilities
Version: 0.0.0
Release: 1
License: TODO
Group: System Environment/Tools
URL: https://github.com/sailfishos/sailfish-utilities
Source0: %{name}-%{version}.tar.bz2
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-buildroot
Requires:  sailfishsilica-qt5
Requires: cutes-js >= 0.8
Requires: cutes >= 0.8
Requires: qt5-qtdeclarative-systeminfo
Requires: jolla-settings-system >= 0.1.69
Requires: nemo-qml-plugin-notifications-qt5
Requires: nemo-qml-plugin-systemsettings
Requires: nemo-qml-plugin-dbus-qt5
Requires:  mapplauncherd-booster-silica-qt5
BuildRequires: cmake >= 2.8
BuildRequires: qt5-default
BuildRequires: qt5-qttools
BuildRequires: qt5-qttools-linguist
Requires: sailfish-utilities-all-translations >= 0.0.1-10.1.4.jolla

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
%{_datadir}/sailfish-utilities/*.qml
%{_datadir}/sailfish-utilities/*.js
%{_datadir}/sailfish-utilities/*.sh
%{_datadir}/jolla-settings/entries/utilities.json
%{_datadir}/translations/settings-sailfish_utilities_eng_en.qm
%{_datadir}/lipstick/notificationcategories/x-sailfish.sailfish-utilities.error.conf
%{_datadir}/lipstick/notificationcategories/x-sailfish.sailfish-utilities.info.conf

%files ts-devel
%defattr(-,root,root,-)
%{_datadir}/translations/source/settings-sailfish_utilities.ts
