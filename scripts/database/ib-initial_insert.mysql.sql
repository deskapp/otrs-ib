# ----------------------------------------------------------
#  driver: mysql, generated: 2011-09-14 13:26:39
# ----------------------------------------------------------
# ----------------------------------------------------------
#  insert into table notifications
# ----------------------------------------------------------
INSERT INTO notifications (notification_type, notification_charset, notification_language, subject, text, content_type, create_by, create_time, change_by, change_time)
    VALUES
    ('Agent::NewTicket', 'utf-8', 'pl', 'Nowe zgłoszenie (<OTRS_CUSTOMER_SUBJECT[50]>)', 'Witaj <OTRS_UserFirstname>,W kolejce "<OTRS_TICKET_Queue>" pojawiło się nowe zgłoszenie <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET_TicketNumber>.Zgłoszenie możesz obsłużyć na stronie:<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/agent/<OTRS_TICKET_TicketNumber>System <OTRS_CONFIG_ProductName>________________________________Od: <OTRS_CUSTOMER_FROM>Temat: <OTRS_CUSTOMER_SUBJECT>Fragment otrzymanej wiadomości:<OTRS_CUSTOMER_EMAIL[30]>', 'text/plain', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table notifications
# ----------------------------------------------------------
INSERT INTO notifications (notification_type, notification_charset, notification_language, subject, text, content_type, create_by, create_time, change_by, change_time)
    VALUES
    ('Agent::FollowUp', 'utf-8', 'pl', 'Nowa wiadomość do zgłoszenia (<OTRS_CUSTOMER_SUBJECT[50]>)', 'Witaj <OTRS_UserFirstname>,Pojawiła się nowa wiadomość do zgłoszenia <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET_TicketNumber>.Zgłoszenie możesz obsłużyć na stronie:<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/agent/<OTRS_TICKET_TicketNumber>System <OTRS_CONFIG_ProductName>________________________________Od: <OTRS_CUSTOMER_FROM>Temat: <OTRS_CUSTOMER_SUBJECT>Fragment otrzymanej wiadomości:<OTRS_CUSTOMER_EMAIL[30]>', 'text/plain', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table notifications
# ----------------------------------------------------------
INSERT INTO notifications (notification_type, notification_charset, notification_language, subject, text, content_type, create_by, create_time, change_by, change_time)
    VALUES
    ('Agent::LockTimeout', 'utf-8', 'pl', 'Odblokowanie zgłoszenia (<OTRS_CUSTOMER_SUBJECT[50]>)', 'Witaj <OTRS_UserFirstname>,Przypisane do ciebie zgłoszenie <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET_TicketNumber>, znajdujące się w kolejce "<OTRS_TICKET_Queue>" zostało odblokowane.Zgłoszenie możesz obsłużyć na stronie:<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/agent/<OTRS_TICKET_TicketNumber>System <OTRS_CONFIG_ProductName>________________________________Od: <OTRS_CUSTOMER_FROM>Temat: <OTRS_CUSTOMER_SUBJECT>Fragment otrzymanej wiadomości:<OTRS_CUSTOMER_EMAIL[30]>', 'text/plain', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table notifications
# ----------------------------------------------------------
INSERT INTO notifications (notification_type, notification_charset, notification_language, subject, text, content_type, create_by, create_time, change_by, change_time)
    VALUES
    ('Agent::OwnerUpdate', 'utf-8', 'pl', 'Przypisanie zgłoszenia (<OTRS_CUSTOMER_SUBJECT[50]>)', 'Witaj <OTRS_UserFirstname>,<OTRS_CURRENT_UserFirstname> <OTRS_CURRENT_UserLastname> przydzielił(a) tobie zgłoszenie <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET_TicketNumber>.Komentarz:<OTRS_COMMENT>Zgłoszenie możesz obsłużyć na stronie:<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/agent/<OTRS_TICKET_TicketNumber>System <OTRS_CONFIG_ProductName>________________________________Od: <OTRS_CUSTOMER_FROM>Temat: <OTRS_CUSTOMER_SUBJECT>Fragment otrzymanej wiadomości:<OTRS_CUSTOMER_EMAIL[30]>', 'text/plain', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table notifications
# ----------------------------------------------------------
INSERT INTO notifications (notification_type, notification_charset, notification_language, subject, text, content_type, create_by, create_time, change_by, change_time)
    VALUES
    ('Agent::ResponsibleUpdate', 'utf-8', 'pl', 'Przypisanie odpowiedzialności za zgłoszenie (<OTRS_CUSTOMER_SUBJECT[50]>)', 'Witaj <OTRS_RESPONSIBLE_UserFirstname>,<OTRS_CURRENT_UserFirstname> <OTRS_CURRENT_UserLastname> wskazał ciebie jako osobę odpowiedzialną za zgłoszenie <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET_TicketNumber>.Komentarz:<OTRS_COMMENT>Zgłoszenie znajduje się na stronie:<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/agent/<OTRS_TICKET_TicketNumber>System <OTRS_CONFIG_ProductName>________________________________Od: <OTRS_CUSTOMER_FROM>Temat: <OTRS_CUSTOMER_SUBJECT>Fragment otrzymanej wiadomości:<OTRS_CUSTOMER_EMAIL[30]>', 'text/plain', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table notifications
# ----------------------------------------------------------
INSERT INTO notifications (notification_type, notification_charset, notification_language, subject, text, content_type, create_by, create_time, change_by, change_time)
    VALUES
    ('Agent::AddNote', 'utf-8', 'pl', 'Nowa notatka do zgłoszenia (<OTRS_CUSTOMER_SUBJECT[50]>)', 'Witaj <OTRS_UserFirstname>,<OTRS_CURRENT_UserFirstname> <OTRS_CURRENT_UserLastname> dodał(a) nową notatkę do zgłoszenia <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET_TicketNumber>.Treść notatki:<OTRS_CUSTOMER_BODY>Zgłoszenie możesz obsłużyć na stronie:<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/agent/<OTRS_TICKET_TicketNumber>System <OTRS_CONFIG_ProductName>________________________________Od: <OTRS_CUSTOMER_FROM>Temat: <OTRS_CUSTOMER_SUBJECT>Fragment otrzymanej wiadomości:<OTRS_CUSTOMER_EMAIL[30]>', 'text/plain', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table notifications
# ----------------------------------------------------------
INSERT INTO notifications (notification_type, notification_charset, notification_language, subject, text, content_type, create_by, create_time, change_by, change_time)
    VALUES
    ('Agent::Move', 'utf-8', 'pl', 'Przeniesienie zgłoszenia (<OTRS_CUSTOMER_SUBJECT[50]>)', 'Witaj <OTRS_UserFirstname>,Zgłoszenie <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET_TicketNumber> zostało przeniesione przez <OTRS_CURRENT_UserFirstname> <OTRS_CURRENT_UserLastname> do kolejki "<OTRS_CUSTOMER_QUEUE>".Zgłoszenie możesz obsłużyć na stronie:<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/agent/<OTRS_TICKET_TicketNumber>System <OTRS_CONFIG_ProductName>________________________________Od: <OTRS_CUSTOMER_FROM>Temat: <OTRS_CUSTOMER_SUBJECT>Fragment otrzymanej wiadomości:<OTRS_CUSTOMER_EMAIL[30]>', 'text/plain', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table notifications
# ----------------------------------------------------------
INSERT INTO notifications (notification_type, notification_charset, notification_language, subject, text, content_type, create_by, create_time, change_by, change_time)
    VALUES
    ('Agent::PendingReminder', 'utf-8', 'pl', 'Przypomnienie o zgłoszeniu (<OTRS_CUSTOMER_SUBJECT[50]>)', 'Witaj <OTRS_UserFirstname>,W kolejce "<OTRS_TICKET_Queue>" znajduje się zgłoszenie <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET_TicketNumber>, dla którego ustawiona została wysyłka tego przypomnienia.Zgłoszenie możesz obsłużyć na stronie:<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/agent/<OTRS_TICKET_TicketNumber>System <OTRS_CONFIG_ProductName>________________________________Od: <OTRS_CUSTOMER_FROM>Temat: <OTRS_CUSTOMER_SUBJECT>Fragment otrzymanej wiadomości:<OTRS_CUSTOMER_EMAIL[30]>', 'text/plain', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table notifications
# ----------------------------------------------------------
INSERT INTO notifications (notification_type, notification_charset, notification_language, subject, text, content_type, create_by, create_time, change_by, change_time)
    VALUES
    ('Agent::Escalation', 'utf-8', 'pl', 'Eskalacja zgłoszenia (<OTRS_CUSTOMER_SUBJECT[50]>)', 'Witaj <OTRS_UserFirstname>,Zgłoszenie <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET_TicketNumber> jest eskalowane.Zgłoszenie możesz obsłużyć na stronie:<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/agent/<OTRS_TICKET_TicketNumber>System <OTRS_CONFIG_ProductName>________________________________Od: <OTRS_CUSTOMER_FROM>Temat: <OTRS_CUSTOMER_SUBJECT>Fragment otrzymanej wiadomości:<OTRS_CUSTOMER_EMAIL[30]>', 'text/plain', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table notifications
# ----------------------------------------------------------
INSERT INTO notifications (notification_type, notification_charset, notification_language, subject, text, content_type, create_by, create_time, change_by, change_time)
    VALUES
    ('Agent::EscalationNotifyBefore', 'utf-8', 'pl', 'Ostrzeżenie przed eskalacją zgłoszenia (<OTRS_CUSTOMER_SUBJECT[50]>)', 'Witaj <OTRS_UserFirstname>,Zgłoszenie <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET_TicketNumber> będzie wkrótce eskalowane.Data eskalacji: <OTRS_TICKET_EscalationDestinationDate>Eskalacja za:   <OTRS_TICKET_EscalationDestinationIn>Zgłoszenie możesz obsłużyć na stronie:<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/agent/<OTRS_TICKET_TicketNumber>System <OTRS_CONFIG_ProductName>________________________________Od: <OTRS_CUSTOMER_FROM>Temat: <OTRS_CUSTOMER_SUBJECT>Fragment otrzymanej wiadomości:<OTRS_CUSTOMER_EMAIL[30]>', 'text/plain', 1, current_timestamp, 1, current_timestamp);
