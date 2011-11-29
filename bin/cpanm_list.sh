#!/bin/sh

#curl -L http://cpanmin.us/ | perl - App::cpanminus

modules="
Math::BigInt::GMP

App::Ack
CGI::Simple::Cookie
Cache::Memcached::Fast
Clone
Config::Pit
Crypt::CBC
Crypt::DH
Crypt::SSLeay
DBD::mysql
DBI
Data::FormValidator
Data::ObjectDriver
Data::Page::Navigation
Digest::SHA
Digest::SHA1
Email::Valid::Loose
Encode::JavaScript::UCS
Error::Simple
File::Slurp
FormValidator::Lite
HTML::FillInForm
HTML::FillInForm::Lite
HTML::Template
HTTP::Status
Hash::MultiValue
JSON::XS
Linux::Inotify2
List::Util
Module::Pluggable::Fast
Net::CIDR::Lite
Net::SSLeay
Net::Server::SS::PreFork
Object::Generic::False
Parallel::Scoreboard
Plack
Plack::Handler::Starman
Plack::Middleware::ReverseProxy
Plack::Middleware::Session
Plack::Runner
Router::Simple
Router::Simple::Declare
Server::Starter
String::CamelCase
Text::Xslate
Text::Xslate::Bridge::TT2Like
TheSchwartz
TheSchwartz::Job
TheSchwartz::Simple
TheSchwartz::Simple::Job
TheSchwartz::Worker
Time::HiRes
Time::Out
Time::Piece
XML::Feed
XML::OPML
XML::Parser
XML::Parser::Expat
XMLRPC::Lite
YAML::XS
"

for module in $modules
do
    cpanm --skip-installed $module
done
