[![Build Status](https://travis-ci.org/OTRS/otrs.svg?branch=rel-5_0)](https://travis-ci.org/OTRS/otrs)

What is OTRS?
=============
OTRS (the former Open Ticket Request System now stands for Open Technology
 – Real Service) is an open source ticket request system with many features
to manage customer telephone calls and e-mails. It is distributed under the
GNU General Public License (GPL) and tested on various Linux platforms.
Do you receive many e-mails and want to answer them with a team of agents? You're going to love OTRS!

You can find a list of features in the
[online documentation](http://otrs.github.io/doc/manual/admin/5.0/en/html/otrs.html#features-of-otrs).


License
=======
It is distributed under the GNU General Public License - see the
accompanying [COPYING](COPYING) file for more details.


Documentation
=============
You can find documentation [online](http://doc.otrs.com/). The source code of OTRS and its public extension
modules is available on [github](https://github.com/OTRS).


Professional Services for OTRS
==============================

Whether you need help in configuring or customizing OTRS or you want to be on the safe side,
don't hesitate to contact us: We offer a wide range of professional services such as
world-wide enterprise support, consulting and engineering including process design,
implementation, customization, application support, and fully managed service.

We offer best professional support from the OTRS team, reliable OTRS security and regular free updates as well as an
[exclusive set of additional Business Features](https://otrs.com/how-to-buy/packages/#feature-add-ons) that you can
flexibly activate or deactivate according to different deployment scenarios.

The [OTRS Group](https://www.otrs.com/) offers specific [training programs](https://otrs.com/academy/#trainings) in
different countries. You can either participate in one of our public OTRS Administrator training seminars which take
place regularly, or benefit from an inhouse training seminar that covers all the specific needs of your company.


Software requirements
=====================
Perl
- Perl 5.14.0 or higher

Webserver
- Apache2 + mod_perl2 or higher (recommended)
- Webserver with CGI support (CGI is not recommended)

Databases
- MySQL 5.0 or higher (MySQL 8+ is [not supported](https://bugs.otrs.org/show_bug.cgi?id=13866))
- MariaDB
- PostgreSQL 9.0 or higher
- Oracle 10g or higher

Browsers
- Use a modern web browser.
- These browsers are not supported:
  - Internet Explorer before version 10
  - Firefox before version 10
  - Safari before version 5


Directories & Files
===================
    $HOME (e. g. /opt/otrs/)
    |
    |  (all executables)
    |--/bin/             (all system programs)
    |   |--/otrs.PostMaster.pl      (email2db)
    |   |--/otrs.PostMasterMail.pl  (email2db)
    |   |--/cgi-bin/
    |   |   |----- /index.pl        (Global Agent & Admin handle)
    |   |   |----- /customer.pl     (Global Customer handle)
    |   |   |----- /public.pl       (Global Public handle)
    |   |   |----- /installer.pl    (Global Installer handle)
    |   |   |----- /nph-genericinterface.pl (Global GenericInterface handle)
    |   |--/fcgi-bin/               (If you're using FastCGI)
    |
    |  (all modules)
    |--/Kernel/
    |   |-----/Config.pm      (main configuration file)
    |   |---- /Config/        (Configuration files)
    |   |      |---- /Files/  (System generated, don't touch...)
    |   |
    |   |---- /Output/        (all output generating modules)
    |   |      |---- /HTML/
    |   |             |---- /Templates/
    |   |                    |--- /Standard/*.tt (all tt files for Standard theme)
    |   |
    |   |--- /GenericInterface (GenericInterface framework)
    |          |--- /Invoker/ (invoker backends)
    |          |--- /Mapping/ (data mapping backends)
    |          |--- /Operation/ (operation backends)
    |          |--- /Transport/ (network transport backends)
    |   |
    |   |---- /Language/      (all translation files)
    |   |
    |   |---- /Modules/        (all action modules e. g. QueueView, Move, ...)
    |   |      |----- /Admin*      (all modules for the admin interface)
    |   |      |----- /Agent*      (all modules for the agent interface)
    |   |      |----- /Customer*   (all modules for the customer interface)
    |   |
    |   |---- /System/         (back-end API modules, selection below)
    |           |--- /Auth.pm        (authentication module)
    |           |--- /AuthSession.pm (session authentication module)
    |           |--- /Daemon         (all daemon files)
    |                 |--- /DaemonModules    (all daemon modules)
    |                       |---SchdulerTaskWorker    (all scheduler worker daemon task handlers)
    |           |--- /DB.pm          (central DB interface)
    |           |--- /DB/*.pm        (DB drivers)
    |           |--- /DynamicField.pm (Interface to the DynamicField configuration)
    |           |--- /DynamicField
    |                 |--- /Backend.pm (Interface for using the dynamic fields)
    |                 |--- /Backend/*.pm (DynamicField backend implementations)
    |                 |--- /ObjectType/*.pm (DynamicField object type implementations)
    |           |--- /Email.pm       (create and send e-mail)
    |           |--- /EmailParser.pm (parsing e-mail)
    |           |--- /GenericInterface/*.pm (all DB related GenericInterface modules)
    |           |--- /Group.pm       (group module)
    |           |--- /Log.pm         (log module)
    |           |--- /Queue.pm       (information about queues. e. g. response templates, ...)
    |           |--- /Ticket.pm      (ticket and article functions)
    |           |--- /User.pm        (user module)
    |           |--- /Web/*.pm       (core interface modules)
    |                 |--- /Request.pm    (HTTP/CGI abstraction module)
    |
    |  (data stuff)
    |--/var/
    |   |--/article/               (all incoming e-mails, plain 1/1 and all attachments ...
    |   |                            ... separately (different files), if you want to store on disk)
    |   |--/cron/                  (all cron jobs for escalations and such)
    |   |
    |   |--/fonts/                 (true type fonts for PDF generation)
    |   |
    |   |--/httpd/                 (all static files served by HTTP)
    |   |   |--- /htdocs/
    |   |         |--- /js/        (javascript files for OTRS)
    |   |               |--- /js-cache/        (auto-generated minified JS files)
    |   |               |--- /thirdparty/      (contains jQuery, CKEditor and other external JS libraries)
    |   |         |--- /skins/     (CSS and images for front end)
    |   |               |--- /Agent/        (Agent skins)
    |   |                     |--- /default/ (default skin)
    |   |                           |--- /css/ (stylesheets)
    |   |                           |--- /css-cache/ (auto-generated minified CSS files)
    |   |                           |--- /img/ (images)
    |   |                     |--- /slim/    (additional skin)
    |   |                           |--- /.../ (files)
    |   |                     |--- /ivory/   (additional skin)
    |   |                           |--- /.../ (files)
    |   |               |--- /Customer/     (Customer skins)
    |   |                     |--- /default/ (default skin)
    |   |                           |--- /.../ (files)
    |   |                     |--- /ivory/
    |   |                           |--- /.../ (files)
    |   |
    |   |--/log/                   (log files)
    |   |   |--/TicketCounter.log  (ticket counter)
    |   |
    |   |--/sessions/              (session info)
    |   |
    |   |--/spool/                 (spool files)
    |   |
    |   |--/stats/                 (statistics)
    |   |
    |   |--/tmp/                   (temporary files, such as cache)
    |
    |  (tools stuff)
    |--/scripts/
        |----  /database/
                |--- /otrs-schema.(mysql|postgresql|*).sql (create database script)
                |--- /otrs-initial_insert.(mysql|postgresql|*).sql (all initial sql data - e. g.
                |                                                   root user, queues, ...)
                |--- /otrs-schema-post.(mysql|postgresql|*).sql (create foreign keys script)
