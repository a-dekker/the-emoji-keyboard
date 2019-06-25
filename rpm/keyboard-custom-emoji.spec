Name:      keyboard-custom-emoji

%{!?qtc_qmake:%define qtc_qmake %qmake}
%{!?qtc_qmake5:%define qtc_qmake5 %qmake5}
%{!?qtc_make:%define qtc_make make}
%{?qtc_builddir:%define _builddir %qtc_builddir}

Summary:    The Emoji+ Keyboard
Version:    0.4.4
Release:    5
Group:      System/GUI/Other
License:    Apache 2.0
Source0:    %{name}-%{version}.tar.bz2
BuildArch:  noarch
BuildRequires:  qt5-qttools
BuildRequires:  qt5-qmake

#Requires:   maliit-server

%description
Enables a rich set of Emoji characters in native SailfishOS applications.
Includes keyboard layouts and needed font to type and display Emojis.

%prep
%setup -q -n %{name}-%{version}

%build

%qtc_qmake5

%qtc_make %{?_smp_mflags}

%install
rm -rf %{buildroot}
%qmake5_install

%files
%defattr(644,root,root,755)
%{_datadir}/maliit/plugins/com/jolla
%{_datadir}/maliit/plugins/com/jolla/layouts/*
%{_datadir}/maliit/plugins/com/jolla/custom_emoji/*
%{_datadir}/fonts/custom/*

%post
systemctl-user restart maliit-server.service

%postun
systemctl-user restart maliit-server.service
