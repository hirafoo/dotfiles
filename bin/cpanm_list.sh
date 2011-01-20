#!/bin/sh

#curl -L http://cpanmin.us/ | perl - App::cpanminus

for name in Math::BigInt::GMP CGI::Simple::Cookie Data::FormValidator Data::ObjectDriver DBD::mysql DBI Error::Simple FormValidator::Lite Hash::MultiValue HTML::FillInForm HTTP::Status JSON::XS List::Util Net::Server::SS::PreFork Object::Generic::False Plack Plack::Handler::Starman Plack::Middleware::ReverseProxy Plack::Runner Router::Simple Router::Simple::Declare Server::Starter TheSchwartz TheSchwartz::Job TheSchwartz::Simple TheSchwartz::Simple::Job TheSchwartz::Worker Time::HiRes XML::OPML XML::Parser XML::Parser::Expat YAML::XS Encode::JavaScript::UCS Crypt::DH Net::CIDR::Lite Server::Starter Plack::Middleware::ReverseProxy Net::Server::SS::PreFork Linux::Inotify2 XML::Feed HTML::FillInForm::Lite Text::Xslate Cache::Memcached::Fast Clone Config::Pit Crypt::CBC Crypt::DH Data::Page::Navigation Email::Valid::Loose File::Slurp HTML::Template Math::BigInt::GMP Module::Pluggable::Fast Parallel::Scoreboard String::CamelCase Time::Out Time::Piece XMLRPC::Lite Plack::Middleware::Session Digest::SHA1 Digest::SHA App::Ack Text::Xslate::Bridge::TT2Like Net::SSLeay Crypt::SSLeay
do
    cpanm --skip-installed $name
done
