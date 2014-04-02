Summary: Miscellaneous Sailfish Tools
Name: sailfish-tiny-tools
Version: 0.0.0
Release: 1
License: TODO
Group: System Environment/Tools
URL: https://github.com/sailfish/sailfish-tiny-tools
Source0: %{name}-%{version}.tar.bz2
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-buildroot
Requires:  sailfishsilica-qt5
Requires: cutes-js >= 0.8
Requires: cutes >= 0.8
BuildRequires: cmake >= 2.8

%description
Miscellaneous Sailfish Tools

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
%{_bindir}/repair_rpm_db
%{_datadir}/applications/sailfish-tiny-tools.desktop
%{_datadir}/sailfish-tiny-tools/*.qml
%{_datadir}/sailfish-tiny-tools/*.js
%{_datadir}/sailfish-tiny-tools/repair_rpm_db.sh
