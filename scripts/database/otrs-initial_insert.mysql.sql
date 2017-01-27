# ----------------------------------------------------------
#  driver: mysql
# ----------------------------------------------------------
# ----------------------------------------------------------
#  insert into table valid
# ----------------------------------------------------------
INSERT INTO valid (id, name, create_by, create_time, change_by, change_time)
    VALUES
    (1, 'valid', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table valid
# ----------------------------------------------------------
INSERT INTO valid (id, name, create_by, create_time, change_by, change_time)
    VALUES
    (2, 'invalid', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table valid
# ----------------------------------------------------------
INSERT INTO valid (id, name, create_by, create_time, change_by, change_time)
    VALUES
    (3, 'invalid-temporarily', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table users
# ----------------------------------------------------------
INSERT INTO users (id, first_name, last_name, login, pw, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (1, 'Admin', 'OTRS', 'root@localhost', 'roK20XGbWEsSM', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table groups
# ----------------------------------------------------------
INSERT INTO groups (id, name, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (1, 'users', 'Grupa z domyślnymi uprawnieniami.', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table groups
# ----------------------------------------------------------
INSERT INTO groups (id, name, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (2, 'admin', 'Grupa z uprawnieniami administratora systemu.', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table groups
# ----------------------------------------------------------
INSERT INTO groups (id, name, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (3, 'stats', 'Grupa z uprawnieniami do korzystania z modułu statystyk.', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table groups
# ----------------------------------------------------------
INSERT INTO groups (id, name, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (4, 'staff', 'Grupa z uprawnieniami agenta systemu.', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table group_user
# ----------------------------------------------------------
INSERT INTO group_user (user_id, group_id, permission_key, permission_value, create_by, create_time, change_by, change_time)
    VALUES
    (1, 1, 'rw', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table group_user
# ----------------------------------------------------------
INSERT INTO group_user (user_id, group_id, permission_key, permission_value, create_by, create_time, change_by, change_time)
    VALUES
    (1, 2, 'rw', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table group_user
# ----------------------------------------------------------
INSERT INTO group_user (user_id, group_id, permission_key, permission_value, create_by, create_time, change_by, change_time)
    VALUES
    (1, 3, 'rw', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table group_user
# ----------------------------------------------------------
INSERT INTO group_user (user_id, group_id, permission_key, permission_value, create_by, create_time, change_by, change_time)
    VALUES
    (1, 4, 'rw', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table link_type
# ----------------------------------------------------------
INSERT INTO link_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('Normal', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table link_type
# ----------------------------------------------------------
INSERT INTO link_type (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('ParentChild', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table link_state
# ----------------------------------------------------------
INSERT INTO link_state (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('Valid', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table link_state
# ----------------------------------------------------------
INSERT INTO link_state (name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    ('Temporary', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_state_type
# ----------------------------------------------------------
INSERT INTO ticket_state_type (id, name, comments, create_by, create_time, change_by, change_time)
    VALUES
    (1, 'new', 'All new state types (default: viewable).', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_state_type
# ----------------------------------------------------------
INSERT INTO ticket_state_type (id, name, comments, create_by, create_time, change_by, change_time)
    VALUES
    (2, 'open', 'All open state types (default: viewable).', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_state_type
# ----------------------------------------------------------
INSERT INTO ticket_state_type (id, name, comments, create_by, create_time, change_by, change_time)
    VALUES
    (3, 'closed', 'All closed state types (default: not viewable).', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_state_type
# ----------------------------------------------------------
INSERT INTO ticket_state_type (id, name, comments, create_by, create_time, change_by, change_time)
    VALUES
    (4, 'pending reminder', 'All \'pending reminder\' state types (default: viewable).', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_state_type
# ----------------------------------------------------------
INSERT INTO ticket_state_type (id, name, comments, create_by, create_time, change_by, change_time)
    VALUES
    (5, 'pending auto', 'All \'pending auto *\' state types (default: viewable).', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_state_type
# ----------------------------------------------------------
INSERT INTO ticket_state_type (id, name, comments, create_by, create_time, change_by, change_time)
    VALUES
    (6, 'removed', 'All \'removed\' state types (default: not viewable).', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_state_type
# ----------------------------------------------------------
INSERT INTO ticket_state_type (id, name, comments, create_by, create_time, change_by, change_time)
    VALUES
    (7, 'merged', 'State type for merged tickets (default: not viewable).', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_state
# ----------------------------------------------------------
INSERT INTO ticket_state (id, name, comments, type_id, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (1, 'new', 'New ticket created by customer.', 1, 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_state
# ----------------------------------------------------------
INSERT INTO ticket_state (id, name, comments, type_id, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (2, 'closed successful', 'Ticket is closed successful.', 3, 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_state
# ----------------------------------------------------------
INSERT INTO ticket_state (id, name, comments, type_id, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (3, 'closed unsuccessful', 'Ticket is closed unsuccessful.', 3, 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_state
# ----------------------------------------------------------
INSERT INTO ticket_state (id, name, comments, type_id, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (4, 'open', 'Open tickets.', 2, 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_state
# ----------------------------------------------------------
INSERT INTO ticket_state (id, name, comments, type_id, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (5, 'removed', 'Customer removed ticket.', 6, 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_state
# ----------------------------------------------------------
INSERT INTO ticket_state (id, name, comments, type_id, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (6, 'pending reminder', 'Ticket is pending for agent reminder.', 4, 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_state
# ----------------------------------------------------------
INSERT INTO ticket_state (id, name, comments, type_id, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (7, 'pending auto close+', 'Ticket is pending for automatic close.', 5, 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_state
# ----------------------------------------------------------
INSERT INTO ticket_state (id, name, comments, type_id, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (8, 'pending auto close-', 'Ticket is pending for automatic close.', 5, 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_state
# ----------------------------------------------------------
INSERT INTO ticket_state (id, name, comments, type_id, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (9, 'merged', 'State for merged tickets.', 7, 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table salutation
# ----------------------------------------------------------
INSERT INTO salutation (id, name, text, content_type, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (1, 'standardowe powitanie', 'Witam,
', 'text/plain\; charset=utf-8', 'Standardowe powitanie.', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table signature
# ----------------------------------------------------------
INSERT INTO signature (id, name, text, content_type, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (1, 'standardowy podpis', '
Pozdrawiam,
<OTRS_Agent_UserFirstname> <OTRS_Agent_UserLastname>
', 'text/plain\; charset=utf-8', 'Standardowy podpis.', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table system_address
# ----------------------------------------------------------
INSERT INTO system_address (id, value0, value1, comments, valid_id, queue_id, create_by, create_time, change_by, change_time)
    VALUES
    (1, 'otrs@localhost', 'OTRS System', 'Standard Address.', 1, 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table follow_up_possible
# ----------------------------------------------------------
INSERT INTO follow_up_possible (id, name, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (1, 'possible', 'Follow-ups for closed tickets are possible. Ticket will be reopened.', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table follow_up_possible
# ----------------------------------------------------------
INSERT INTO follow_up_possible (id, name, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (2, 'reject', 'Follow-ups for closed tickets are not possible. No new ticket will be created.', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table follow_up_possible
# ----------------------------------------------------------
INSERT INTO follow_up_possible (id, name, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (3, 'new ticket', 'Follow-ups for closed tickets are not possible. A new ticket will be created..', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table queue
# ----------------------------------------------------------
INSERT INTO queue (id, name, group_id, system_address_id, salutation_id, signature_id, follow_up_id, follow_up_lock, unlock_timeout, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (1, 'Zgłoszenia', 1, 1, 1, 1, 1, 1, 60, 'Domyślna kolejka.', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table queue
# ----------------------------------------------------------
INSERT INTO queue (id, name, group_id, system_address_id, salutation_id, signature_id, follow_up_id, follow_up_lock, unlock_timeout, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (2, 'Kosz', 4, 1, 1, 1, 1, 1, 60, 'Kolejka na niechciane zgłoszenia.', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table standard_template
# ----------------------------------------------------------
INSERT INTO standard_template (id, name, text, content_type, template_type, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (1, 'Obsługa trwa', 'Obsługa zgłoszenia o numerze <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET_TicketNumber> trwa.', 'text/plain\; charset=utf-8', 'Answer', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table standard_template
# ----------------------------------------------------------
INSERT INTO standard_template (id, name, text, content_type, template_type, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (2, 'Obsługa zakończona', 'Obsługa zgłoszenia o numerze <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET_TicketNumber> została zakończona.', 'text/plain\; charset=utf-8', 'Answer', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table queue_standard_template
# ----------------------------------------------------------
INSERT INTO queue_standard_template (queue_id, standard_template_id, create_by, create_time, change_by, change_time)
    VALUES
    (1, 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table queue_standard_template
# ----------------------------------------------------------
INSERT INTO queue_standard_template (queue_id, standard_template_id, create_by, create_time, change_by, change_time)
    VALUES
    (1, 2, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table auto_response_type
# ----------------------------------------------------------
INSERT INTO auto_response_type (id, name, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (1, 'auto reply', 'Automatic reply which will be sent out after a new ticket has been created.', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table auto_response_type
# ----------------------------------------------------------
INSERT INTO auto_response_type (id, name, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (2, 'auto reject', 'Automatic reject which will be sent out after a follow-up has been rejected (in case queue follow-up option is "reject").', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table auto_response_type
# ----------------------------------------------------------
INSERT INTO auto_response_type (id, name, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (3, 'auto follow up', 'Automatic confirmation which is sent out after a follow-up has been received for a ticket (in case queue follow-up option is "possible").', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table auto_response_type
# ----------------------------------------------------------
INSERT INTO auto_response_type (id, name, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (4, 'auto reply/new ticket', 'Automatic response which will be sent out after a follow-up has been rejected and a new ticket has been created (in case queue follow-up option is "new ticket").', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table auto_response_type
# ----------------------------------------------------------
INSERT INTO auto_response_type (id, name, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (5, 'auto remove', 'Auto remove will be sent out after a customer removed the request.', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table auto_response
# ----------------------------------------------------------
INSERT INTO auto_response (id, type_id, system_address_id, name, text0, text1, content_type, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (1, 1, 1, 'default reply (after new ticket has been created)', 'Ta wiadomość została wygenerowana automatycznie.

Państwa zgłoszenie, którego fragment zacytowany jest niżej, zostało zarejestrowane pod numerem

   <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET_TicketNumber>

i wkrótce będzie obsłużone.

________________________________

Temat: <OTRS_CUSTOMER_SUBJECT>

Fragment treści zgłoszenia:
<OTRS_CUSTOMER_EMAIL[20]>', 'RE: <OTRS_CUSTOMER_SUBJECT[50]>', 'text/plain', '', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table auto_response
# ----------------------------------------------------------
INSERT INTO auto_response (id, type_id, system_address_id, name, text0, text1, content_type, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (2, 2, 1, 'default reject (after follow-up and rejected of a closed ticket)', 'Ta wiadomość została wygenerowana automatycznie.

Państwa poprzednie zgłoszenie jest zamknięte a wiadomość do niego została odrzucona.

Prosimy o utworzenie nowego zgłoszenia.', 'Wiadomość e-mail została odrzucona! (RE: <OTRS_CUSTOMER_SUBJECT[50]>)', 'text/plain', '', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table auto_response
# ----------------------------------------------------------
INSERT INTO auto_response (id, type_id, system_address_id, name, text0, text1, content_type, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (3, 3, 1, 'default follow-up (after a ticket follow-up has been added)', 'Ta wiadomość została wygenerowana automatycznie.

Dziękujemy za wiadomość do zgłoszenia.

________________________________

Temat: <OTRS_CUSTOMER_SUBJECT>

Fragment treści zgłoszenia:
<OTRS_CUSTOMER_EMAIL[20]>', 'RE: <OTRS_CUSTOMER_SUBJECT[50]>', 'text/plain', '', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table auto_response
# ----------------------------------------------------------
INSERT INTO auto_response (id, type_id, system_address_id, name, text0, text1, content_type, comments, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (4, 4, 1, 'default reject/new ticket created (after closed follow-up with new ticket creation)', 'Ta wiadomość została wygenerowana automatycznie.

Państwa poprzednie zgłoszenie jest zamknięte. Utworzone zostało nowe zgłoszenie.

________________________________

Temat: <OTRS_CUSTOMER_SUBJECT>

Fragment treści zgłoszenia:
<OTRS_CUSTOMER_EMAIL[20]>', 'Utworzono nowe zgłoszenie! (RE: <OTRS_CUSTOMER_SUBJECT[50]>)', 'text/plain', '', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_type
# ----------------------------------------------------------
INSERT INTO ticket_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (1, 'Unclassified', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_priority
# ----------------------------------------------------------
INSERT INTO ticket_priority (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (1, '1 very low', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_priority
# ----------------------------------------------------------
INSERT INTO ticket_priority (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (2, '2 low', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_priority
# ----------------------------------------------------------
INSERT INTO ticket_priority (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (3, '3 normal', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_priority
# ----------------------------------------------------------
INSERT INTO ticket_priority (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (4, '4 high', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_priority
# ----------------------------------------------------------
INSERT INTO ticket_priority (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (5, '5 very high', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_lock_type
# ----------------------------------------------------------
INSERT INTO ticket_lock_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (1, 'unlock', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_lock_type
# ----------------------------------------------------------
INSERT INTO ticket_lock_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (2, 'lock', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_lock_type
# ----------------------------------------------------------
INSERT INTO ticket_lock_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (3, 'tmp_lock', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (1, 'NewTicket', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (2, 'FollowUp', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (3, 'SendAutoReject', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (4, 'SendAutoReply', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (5, 'SendAutoFollowUp', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (6, 'Forward', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (7, 'Bounce', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (8, 'SendAnswer', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (9, 'SendAgentNotification', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (10, 'SendCustomerNotification', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (11, 'EmailAgent', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (12, 'EmailCustomer', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (13, 'PhoneCallAgent', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (14, 'PhoneCallCustomer', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (15, 'AddNote', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (16, 'Move', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (17, 'Lock', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (18, 'Unlock', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (19, 'Remove', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (20, 'TimeAccounting', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (21, 'CustomerUpdate', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (22, 'PriorityUpdate', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (23, 'OwnerUpdate', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (24, 'LoopProtection', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (25, 'Misc', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (26, 'SetPendingTime', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (27, 'StateUpdate', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (28, 'TicketDynamicFieldUpdate', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (29, 'WebRequestCustomer', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (30, 'TicketLinkAdd', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (31, 'TicketLinkDelete', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (32, 'SystemRequest', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (33, 'Merged', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (34, 'ResponsibleUpdate', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (35, 'Subscribe', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (36, 'Unsubscribe', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (37, 'TypeUpdate', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (38, 'ServiceUpdate', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (39, 'SLAUpdate', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (40, 'ArchiveFlagUpdate', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (41, 'EscalationSolutionTimeStop', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (42, 'EscalationResponseTimeStart', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (43, 'EscalationUpdateTimeStart', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (44, 'EscalationSolutionTimeStart', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (45, 'EscalationResponseTimeNotifyBefore', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (46, 'EscalationUpdateTimeNotifyBefore', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (47, 'EscalationSolutionTimeNotifyBefore', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (48, 'EscalationResponseTimeStop', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (49, 'EscalationUpdateTimeStop', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table ticket_history_type
# ----------------------------------------------------------
INSERT INTO ticket_history_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (50, 'TitleUpdate', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table article_type
# ----------------------------------------------------------
INSERT INTO article_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (1, 'email-external', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table article_type
# ----------------------------------------------------------
INSERT INTO article_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (2, 'email-internal', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table article_type
# ----------------------------------------------------------
INSERT INTO article_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (3, 'email-notification-ext', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table article_type
# ----------------------------------------------------------
INSERT INTO article_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (4, 'email-notification-int', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table article_type
# ----------------------------------------------------------
INSERT INTO article_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (5, 'phone', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table article_type
# ----------------------------------------------------------
INSERT INTO article_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (6, 'fax', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table article_type
# ----------------------------------------------------------
INSERT INTO article_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (7, 'sms', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table article_type
# ----------------------------------------------------------
INSERT INTO article_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (8, 'webrequest', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table article_type
# ----------------------------------------------------------
INSERT INTO article_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (9, 'note-internal', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table article_type
# ----------------------------------------------------------
INSERT INTO article_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (10, 'note-external', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table article_type
# ----------------------------------------------------------
INSERT INTO article_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (11, 'note-report', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table article_sender_type
# ----------------------------------------------------------
INSERT INTO article_sender_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (1, 'agent', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table article_sender_type
# ----------------------------------------------------------
INSERT INTO article_sender_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (2, 'system', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table article_sender_type
# ----------------------------------------------------------
INSERT INTO article_sender_type (id, name, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (3, 'customer', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table notification_event
# ----------------------------------------------------------
INSERT INTO notification_event (id, name, valid_id, comments, create_by, create_time, change_by, change_time)
    VALUES
    (1, 'Ticket create notification', 1, '', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (1, 'VisibleForAgent', '1');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (1, 'VisibleForAgentTooltip', 'You will receive a notification each time a new ticket is created in one of your "My Queues" or "My Services".');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (1, 'Events', 'NotificationNewTicket');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (1, 'Recipients', 'AgentMyQueues');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (1, 'Recipients', 'AgentMyServices');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (1, 'SendOnOutOfOffice', '1');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (1, 'Transports', 'Email');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (1, 'AgentEnabledByDefault', 'Email');
# ----------------------------------------------------------
#  insert into table notification_event
# ----------------------------------------------------------
INSERT INTO notification_event (id, name, valid_id, comments, create_by, create_time, change_by, change_time)
    VALUES
    (2, 'Ticket follow-up notification (unlocked)', 1, '', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (2, 'VisibleForAgent', '1');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (2, 'VisibleForAgentTooltip', 'You will receive a notification if a customer sends a follow-up to an unlocked ticket which is in your "My Queues" or "My Services".');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (2, 'Events', 'NotificationFollowUp');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (2, 'Recipients', 'AgentOwner');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (2, 'Recipients', 'AgentWatcher');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (2, 'Recipients', 'AgentMyQueues');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (2, 'Recipients', 'AgentMyServices');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (2, 'SendOnOutOfOffice', '1');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (2, 'LockID', '1');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (2, 'Transports', 'Email');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (2, 'AgentEnabledByDefault', 'Email');
# ----------------------------------------------------------
#  insert into table notification_event
# ----------------------------------------------------------
INSERT INTO notification_event (id, name, valid_id, comments, create_by, create_time, change_by, change_time)
    VALUES
    (3, 'Ticket follow-up notification (locked)', 1, '', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (3, 'VisibleForAgent', '1');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (3, 'VisibleForAgentTooltip', 'You will receive a notification if a customer sends a follow-up to a locked ticket of which you are the ticket owner or responsible.');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (3, 'Events', 'NotificationFollowUp');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (3, 'Recipients', 'AgentOwner');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (3, 'Recipients', 'AgentResponsible');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (3, 'Recipients', 'AgentWatcher');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (3, 'SendOnOutOfOffice', '1');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (3, 'LockID', '2');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (3, 'LockID', '3');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (3, 'Transports', 'Email');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (3, 'AgentEnabledByDefault', 'Email');
# ----------------------------------------------------------
#  insert into table notification_event
# ----------------------------------------------------------
INSERT INTO notification_event (id, name, valid_id, comments, create_by, create_time, change_by, change_time)
    VALUES
    (4, 'Ticket lock timeout notification', 1, '', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (4, 'VisibleForAgent', '1');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (4, 'VisibleForAgentTooltip', 'You will receive a notification as soon as a ticket owned by you is automatically unlocked.');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (4, 'Events', 'NotificationLockTimeout');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (4, 'Recipients', 'AgentOwner');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (4, 'SendOnOutOfOffice', '1');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (4, 'Transports', 'Email');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (4, 'AgentEnabledByDefault', 'Email');
# ----------------------------------------------------------
#  insert into table notification_event
# ----------------------------------------------------------
INSERT INTO notification_event (id, name, valid_id, comments, create_by, create_time, change_by, change_time)
    VALUES
    (5, 'Ticket owner update notification', 1, '', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (5, 'Events', 'NotificationOwnerUpdate');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (5, 'Recipients', 'AgentOwner');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (5, 'SendOnOutOfOffice', '1');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (5, 'Transports', 'Email');
# ----------------------------------------------------------
#  insert into table notification_event
# ----------------------------------------------------------
INSERT INTO notification_event (id, name, valid_id, comments, create_by, create_time, change_by, change_time)
    VALUES
    (6, 'Ticket responsible update notification', 1, '', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (6, 'Events', 'NotificationResponsibleUpdate');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (6, 'Recipients', 'AgentResponsible');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (6, 'SendOnOutOfOffice', '1');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (6, 'Transports', 'Email');
# ----------------------------------------------------------
#  insert into table notification_event
# ----------------------------------------------------------
INSERT INTO notification_event (id, name, valid_id, comments, create_by, create_time, change_by, change_time)
    VALUES
    (7, 'Ticket new note notification', 1, '', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (7, 'Events', 'NotificationAddNote');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (7, 'Recipients', 'AgentOwner');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (7, 'Recipients', 'AgentResponsible');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (7, 'Recipients', 'AgentWatcher');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (7, 'SendOnOutOfOffice', '1');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (7, 'Transports', 'Email');
# ----------------------------------------------------------
#  insert into table notification_event
# ----------------------------------------------------------
INSERT INTO notification_event (id, name, valid_id, comments, create_by, create_time, change_by, change_time)
    VALUES
    (8, 'Ticket queue update notification', 1, '', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (8, 'VisibleForAgent', '1');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (8, 'VisibleForAgentTooltip', 'You will receive a notification if a ticket is moved into one of your "My Queues".');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (8, 'Events', 'NotificationMove');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (8, 'Recipients', 'AgentMyQueues');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (8, 'SendOnOutOfOffice', '1');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (8, 'Transports', 'Email');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (8, 'AgentEnabledByDefault', 'Email');
# ----------------------------------------------------------
#  insert into table notification_event
# ----------------------------------------------------------
INSERT INTO notification_event (id, name, valid_id, comments, create_by, create_time, change_by, change_time)
    VALUES
    (9, 'Ticket pending reminder notification (locked)', 1, '', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (9, 'Events', 'NotificationPendingReminder');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (9, 'Recipients', 'AgentOwner');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (9, 'Recipients', 'AgentResponsible');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (9, 'SendOnOutOfOffice', '1');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (9, 'OncePerDay', '1');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (9, 'LockID', '2');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (9, 'LockID', '3');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (9, 'Transports', 'Email');
# ----------------------------------------------------------
#  insert into table notification_event
# ----------------------------------------------------------
INSERT INTO notification_event (id, name, valid_id, comments, create_by, create_time, change_by, change_time)
    VALUES
    (10, 'Ticket pending reminder notification (unlocked)', 1, '', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (10, 'Events', 'NotificationPendingReminder');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (10, 'Recipients', 'AgentOwner');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (10, 'Recipients', 'AgentResponsible');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (10, 'Recipients', 'AgentMyQueues');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (10, 'SendOnOutOfOffice', '1');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (10, 'OncePerDay', '1');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (10, 'LockID', '1');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (10, 'Transports', 'Email');
# ----------------------------------------------------------
#  insert into table notification_event
# ----------------------------------------------------------
INSERT INTO notification_event (id, name, valid_id, comments, create_by, create_time, change_by, change_time)
    VALUES
    (11, 'Ticket escalation notification', 1, '', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (11, 'Events', 'NotificationEscalation');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (11, 'Recipients', 'AgentMyQueues');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (11, 'Recipients', 'AgentWritePermissions');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (11, 'SendOnOutOfOffice', '1');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (11, 'OncePerDay', '1');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (11, 'Transports', 'Email');
# ----------------------------------------------------------
#  insert into table notification_event
# ----------------------------------------------------------
INSERT INTO notification_event (id, name, valid_id, comments, create_by, create_time, change_by, change_time)
    VALUES
    (12, 'Ticket escalation warning notification', 1, '', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (12, 'Events', 'NotificationEscalationNotifyBefore');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (12, 'Recipients', 'AgentMyQueues');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (12, 'Recipients', 'AgentWritePermissions');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (12, 'SendOnOutOfOffice', '1');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (12, 'OncePerDay', '1');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (12, 'Transports', 'Email');
# ----------------------------------------------------------
#  insert into table notification_event
# ----------------------------------------------------------
INSERT INTO notification_event (id, name, valid_id, comments, create_by, create_time, change_by, change_time)
    VALUES
    (13, 'Ticket service update notification', 1, '', 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (13, 'VisibleForAgent', '1');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (13, 'VisibleForAgentTooltip', 'You will receive a notification if a ticket\'s service is changed to one of your "My Services".');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (13, 'Events', 'NotificationServiceUpdate');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (13, 'Recipients', 'AgentMyServices');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (13, 'SendOnOutOfOffice', '1');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (13, 'Transports', 'Email');
# ----------------------------------------------------------
#  insert into table notification_event_item
# ----------------------------------------------------------
INSERT INTO notification_event_item (notification_id, event_key, event_value)
    VALUES
    (13, 'AgentEnabledByDefault', 'Email');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (1, 1, 'text/plain', 'en', 'Ticket Created: <OTRS_TICKET_Title>', 'Hi <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] has been created in queue <OTRS_TICKET_Queue>.

<OTRS_CUSTOMER_REALNAME> wrote:
<OTRS_CUSTOMER_BODY[30]>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (2, 2, 'text/plain', 'en', 'Unlocked Ticket Follow-Up: <OTRS_CUSTOMER_SUBJECT[24]>', 'Hi <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

the unlocked ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] received a follow-up.

<OTRS_CUSTOMER_REALNAME> wrote:
<OTRS_CUSTOMER_BODY[30]>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (3, 3, 'text/plain', 'en', 'Locked Ticket Follow-Up: <OTRS_CUSTOMER_SUBJECT[24]>', 'Hi <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

the locked ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] received a follow-up.

<OTRS_CUSTOMER_REALNAME> wrote:
<OTRS_CUSTOMER_BODY[30]>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (4, 4, 'text/plain', 'en', 'Ticket Lock Timeout: <OTRS_TICKET_Title>', 'Hi <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] has reached its lock timeout period and is now unlocked.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (5, 5, 'text/plain', 'en', 'Ticket Owner Update to <OTRS_OWNER_UserFullname>: <OTRS_TICKET_Title>', 'Hi <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

the owner of ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] has been updated to <OTRS_TICKET_OWNER_UserFullname> by <OTRS_CURRENT_UserFullname>.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (6, 6, 'text/plain', 'en', 'Ticket Responsible Update to <OTRS_RESPONSIBLE_UserFullname>: <OTRS_TICKET_Title>', 'Hi <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

the responsible agent of ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] has been updated to <OTRS_TICKET_RESPONSIBLE_UserFullname> by <OTRS_CURRENT_UserFullname>.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (7, 7, 'text/plain', 'en', 'Ticket Note: <OTRS_AGENT_SUBJECT[24]>', 'Hi <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

<OTRS_CURRENT_UserFullname> wrote:
<OTRS_AGENT_BODY[30]>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (8, 8, 'text/plain', 'en', 'Ticket Queue Update to <OTRS_TICKET_Queue>: <OTRS_TICKET_Title>', 'Hi <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] has been updated to queue <OTRS_TICKET_Queue>.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (9, 9, 'text/plain', 'en', 'Locked Ticket Pending Reminder Time Reached: <OTRS_TICKET_Title>', 'Hi <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

the pending reminder time of the locked ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] has been reached.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (10, 10, 'text/plain', 'en', 'Unlocked Ticket Pending Reminder Time Reached: <OTRS_TICKET_Title>', 'Hi <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

the pending reminder time of the unlocked ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] has been reached.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (11, 11, 'text/plain', 'en', 'Ticket Escalation! <OTRS_TICKET_Title>', 'Hi <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] is escalated!

Escalated at: <OTRS_TICKET_EscalationDestinationDate>
Escalated since: <OTRS_TICKET_EscalationDestinationIn>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (12, 12, 'text/plain', 'en', 'Ticket Escalation Warning! <OTRS_TICKET_Title>', 'Hi <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] will escalate!

Escalation at: <OTRS_TICKET_EscalationDestinationDate>
Escalation in: <OTRS_TICKET_EscalationDestinationIn>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>


-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (13, 13, 'text/plain', 'en', 'Ticket Service Update to <OTRS_TICKET_Service>: <OTRS_TICKET_Title>', 'Hi <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

the service of ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] has been updated to <OTRS_TICKET_Service>.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (14, 1, 'text/plain', 'de', 'Ticket erstellt: <OTRS_TICKET_Title>', 'Hallo <OTRS_NOTIFICATION_RECIPIENT_UserFirstname> <OTRS_NOTIFICATION_RECIPIENT_UserLastname>,

das Ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] wurde in der Queue <OTRS_TICKET_Queue> erstellt.

<OTRS_CUSTOMER_REALNAME> schrieb:
<OTRS_CUSTOMER_BODY[30]>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (15, 2, 'text/plain', 'de', 'Nachfrage zum freigegebenen Ticket: <OTRS_CUSTOMER_SUBJECT[24]>', 'Hallo <OTRS_NOTIFICATION_RECIPIENT_UserFirstname> <OTRS_NOTIFICATION_RECIPIENT_UserLastname>,

zum freigegebenen Ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] gibt es eine Nachfrage.

<OTRS_CUSTOMER_REALNAME> schrieb:
<OTRS_CUSTOMER_BODY[30]>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (16, 3, 'text/plain', 'de', 'Nachfrage zum gesperrten Ticket: <OTRS_CUSTOMER_SUBJECT[24]>', 'Hallo <OTRS_NOTIFICATION_RECIPIENT_UserFirstname> <OTRS_NOTIFICATION_RECIPIENT_UserLastname>,

zum gesperrten Ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] gibt es eine Nachfrage.

<OTRS_CUSTOMER_REALNAME> schrieb:
<OTRS_CUSTOMER_BODY[30]>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (17, 4, 'text/plain', 'de', 'Ticketsperre aufgehoben: <OTRS_TICKET_Title>', 'Hallo <OTRS_NOTIFICATION_RECIPIENT_UserFirstname> <OTRS_NOTIFICATION_RECIPIENT_UserLastname>,

die Sperrzeit des Tickets [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] ist abgelaufen. Es ist jetzt freigegeben.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (18, 5, 'text/plain', 'de', 'Änderung des Ticket-Besitzers auf <OTRS_OWNER_UserFullname>: <OTRS_TICKET_Title>', 'Hallo <OTRS_NOTIFICATION_RECIPIENT_UserFirstname> <OTRS_NOTIFICATION_RECIPIENT_UserLastname>,

der Besitzer des Tickets [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] wurde von <OTRS_CURRENT_UserFullname> geändert auf <OTRS_TICKET_OWNER_UserFullname>.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (19, 6, 'text/plain', 'de', 'Änderung des Ticket-Verantwortlichen auf <OTRS_RESPONSIBLE_UserFullname>: <OTRS_TICKET_Title>', 'Hallo <OTRS_NOTIFICATION_RECIPIENT_UserFirstname> <OTRS_NOTIFICATION_RECIPIENT_UserLastname>,

der Verantwortliche für das Ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] wurde von <OTRS_CURRENT_UserFullname> geändert auf <OTRS_TICKET_RESPONSIBLE_UserFullname>.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (20, 7, 'text/plain', 'de', 'Ticket-Notiz: <OTRS_AGENT_SUBJECT[24]>', 'Hallo <OTRS_NOTIFICATION_RECIPIENT_UserFirstname> <OTRS_NOTIFICATION_RECIPIENT_UserLastname>,

<OTRS_CURRENT_UserFullname> schrieb:
<OTRS_AGENT_BODY[30]>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (21, 8, 'text/plain', 'de', 'Ticket-Queue geändert zu <OTRS_TICKET_Queue>: <OTRS_TICKET_Title>', 'Hallo <OTRS_NOTIFICATION_RECIPIENT_UserFirstname> <OTRS_NOTIFICATION_RECIPIENT_UserLastname>,

das Ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] wurde in die Queue <OTRS_TICKET_Queue> verschoben.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (22, 9, 'text/plain', 'de', 'Erinnerungszeit des gesperrten Tickets erreicht: <OTRS_TICKET_Title>', 'Hallo <OTRS_NOTIFICATION_RECIPIENT_UserFirstname> <OTRS_NOTIFICATION_RECIPIENT_UserLastname>,

die Erinnerungszeit für das gesperrte Ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] wurde erreicht.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (23, 10, 'text/plain', 'de', 'Erinnerungszeit des freigegebenen Tickets erreicht: <OTRS_TICKET_Title>', 'Hallo <OTRS_NOTIFICATION_RECIPIENT_UserFirstname> <OTRS_NOTIFICATION_RECIPIENT_UserLastname>,

die Erinnerungszeit für das freigegebene Ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] wurde erreicht.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (24, 11, 'text/plain', 'de', 'Ticket-Eskalation! <OTRS_TICKET_Title>', 'Hallo <OTRS_NOTIFICATION_RECIPIENT_UserFirstname> <OTRS_NOTIFICATION_RECIPIENT_UserLastname>,

das Ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] ist eskaliert!

Eskaliert am: <OTRS_TICKET_EscalationDestinationDate>
Eskaliert seit: <OTRS_TICKET_EscalationDestinationIn>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (25, 12, 'text/plain', 'de', 'Ticket-Eskalations-Warnung! <OTRS_TICKET_Title>', 'Hallo <OTRS_NOTIFICATION_RECIPIENT_UserFirstname> <OTRS_NOTIFICATION_RECIPIENT_UserLastname>,

das Ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] wird bald eskalieren!

Eskalation um: <OTRS_TICKET_EscalationDestinationDate>
Eskalation in: <OTRS_TICKET_EscalationDestinationIn>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>


-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (26, 13, 'text/plain', 'de', 'Ticket-Service aktualisiert zu <OTRS_TICKET_Service>: <OTRS_TICKET_Title>', 'Hallo <OTRS_NOTIFICATION_RECIPIENT_UserFirstname> <OTRS_NOTIFICATION_RECIPIENT_UserLastname>,

der Service des Tickets [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] wurde geändert zu <OTRS_TICKET_Service>.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (27, 1, 'text/plain', 'es_MX', 'Se ha creado un ticket: <OTRS_TICKET_Title>', 'Hola <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

el ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] se ha creado en la fila <OTRS_TICKET_Queue>.

<OTRS_CUSTOMER_REALNAME> escribió:
<OTRS_CUSTOMER_BODY[30]>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (28, 2, 'text/plain', 'es_MX', 'Seguimiento a ticket desbloqueado: <OTRS_CUSTOMER_SUBJECT[24]>', 'Hola <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

el ticket desbloqueado [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] recibió un seguimiento.

<OTRS_CUSTOMER_REALNAME> escribió:
<OTRS_CUSTOMER_BODY[30]>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (29, 3, 'text/plain', 'es_MX', 'Seguimiento a ticket bloqueado: <OTRS_CUSTOMER_SUBJECT[24]>', 'Hola <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

el ticket bloqueado [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] recibió un seguimiento.

<OTRS_CUSTOMER_REALNAME> escribió:
<OTRS_CUSTOMER_BODY[30]>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (30, 4, 'text/plain', 'es_MX', 'Terminó tiempo de bloqueo: <OTRS_TICKET_Title>', 'Hola <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

el ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>]  ha alcanzado su tiempo de espera como bloqueado y ahora se encuentra desbloqueado.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (31, 5, 'text/plain', 'es_MX', 'Actualización del propietario de ticket a <OTRS_OWNER_UserFullname>: <OTRS_TICKET_Title>', 'Hola <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

el propietario del ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] se ha modificado  a <OTRS_TICKET_OWNER_UserFullname> por <OTRS_CURRENT_UserFullname>.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (32, 6, 'text/plain', 'es_MX', 'Actualización del responsable de ticket a <OTRS_RESPONSIBLE_UserFullname>: <OTRS_TICKET_Title>', 'Hola <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

el agente responsable del ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] se ha modificado a <OTRS_TICKET_RESPONSIBLE_UserFullname> por <OTRS_CURRENT_UserFullname>.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (33, 7, 'text/plain', 'es_MX', 'Nota de ticket: <OTRS_AGENT_SUBJECT[24]>', 'Hola <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

<OTRS_CURRENT_UserFullname> escribió:
<OTRS_AGENT_BODY[30]>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (34, 8, 'text/plain', 'es_MX', 'La fila del ticket ha cambiado a <OTRS_TICKET_Queue>: <OTRS_TICKET_Title>', 'Hola <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

el ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] ha cambiado de fila a <OTRS_TICKET_Queue>.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (35, 9, 'text/plain', 'es_MX', 'Recordatorio pendiente en ticket bloqueado se ha alcanzado: <OTRS_TICKET_Title>', 'Hola <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

el tiempo del recordatorio pendiente para el ticket bloqueado [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] se ha alcanzado.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (36, 10, 'text/plain', 'es_MX', 'Recordatorio pendiente en ticket desbloqueado se ha alcanzado: <OTRS_TICKET_Title>', 'Hola <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

el tiempo del recordatorio pendiente para el ticket desbloqueado [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] se ha alcanzado.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (37, 11, 'text/plain', 'es_MX', '¡Escalación de ticket! <OTRS_TICKET_Title>', 'Hola <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

el ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] se ha escalado!

Escaló: <OTRS_TICKET_EscalationDestinationDate>
Escalado desde: <OTRS_TICKET_EscalationDestinationIn>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (38, 12, 'text/plain', 'es_MX', 'Aviso de escalación de ticket! <OTRS_TICKET_Title>', 'Hola <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

el ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] se encuentra proximo a escalar!

Escalará: <OTRS_TICKET_EscalationDestinationDate>
Escalará en: <OTRS_TICKET_EscalationDestinationIn>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>


-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (39, 13, 'text/plain', 'es_MX', 'El servicio del ticket ha cambiado a <OTRS_TICKET_Service>: <OTRS_TICKET_Title>', 'Hola <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

el servicio del ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] se ha cambiado a <OTRS_TICKET_Service>.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (40, 1, 'text/plain', 'zh_CN', '票据编制 工单已创建：<OTRS_TICKET_Title>', '您好 <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

票据工单 [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] 已在等待队列 已在队列<OTRS_TICKET_Queue> 中被编制完成。中被创建完成

<OTRS_CUSTOMER_REALNAME> 写道：
<OTRS_CUSTOMER_BODY[30]>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (41, 2, 'text/plain', 'zh_CN', '解锁票据的后续作业解锁工单的后续： <OTRS_CUSTOMER_SUBJECT[24]>', '您好<OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

解锁票据解锁工单[<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] 已获得一项后续作业。

<OTRS_CUSTOMER_REALNAME> 写道:
<OTRS_CUSTOMER_BODY[30]>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (42, 3, 'text/plain', 'zh_CN', '加锁票据的后续作业 锁定工单后续：<OTRS_CUSTOMER_SUBJECT[24]>', '您好 <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

加锁票据锁定工单 [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] 已获得一项后续作业。

<OTRS_CUSTOMER_REALNAME> 写道：
<OTRS_CUSTOMER_BODY[30]>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (43, 4, 'text/plain', 'zh_CN', '票据加锁超时工单锁定超时：<OTRS_TICKET_Title>', '您好 <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

票据工单 [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] 已达到其锁定时限，现在解锁。

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (44, 5, 'text/plain', 'zh_CN', '票据的拥有人升级为工单所有者更新为 <OTRS_OWNER_UserFullname>: <OTRS_TICKET_Title>', '您好 <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

票据的所有人工单的所有者 [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] 已被该信为 <OTRS_TICKET_OWNER_UserFullname> 的 <OTRS_CURRENT_UserFullname>。

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (45, 6, 'text/plain', 'zh_CN', '票据的负责人 工单负责人更新为<OTRS_RESPONSIBLE_UserFullname>: <OTRS_TICKET_Title>', '您好 <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

工单的负责人 [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] 已被升级为 已被更新为 <OTRS_TICKET_RESPONSIBLE_UserFullname> 的 <OTRS_CURRENT_UserFullname>.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (46, 7, 'text/plain', 'zh_CN', '票据备注工单备注：<OTRS_AGENT_SUBJECT[24]>', '您好 <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

<OTRS_CURRENT_UserFullname> 写道：
<OTRS_AGENT_BODY[30]>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (47, 8, 'text/plain', 'zh_CN', '票据序列已升级为工单队列更新为<OTRS_TICKET_Queue>: <OTRS_TICKET_Title>', '您好 <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

票据工单 [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] 已被升级为序列已被更新为队列 <OTRS_TICKET_Queue>。

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (48, 9, 'text/plain', 'zh_CN', '已达到锁定票据即将到期的提醒时间已到达锁定工单挂起提醒时间：<OTRS_TICKET_Title>', '您好 <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

锁定票据即将到期的提醒时间锁定工单挂起提醒时间 [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] 已到达。

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (49, 10, 'text/plain', 'zh_CN', '未锁定票据即将到期的提醒时间已到已到未锁定工单的挂起提醒时间：<OTRS_TICKET_Title>', '您好 <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

未锁定票据即将到期的提醒时间未锁定工单的挂起提醒时间 [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] 已到已到达。

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (50, 11, 'text/plain', 'zh_CN', '票据升级！工单升级！<OTRS_TICKET_Title>', '您好 <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

票据工单 [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] 已被升级！

升级地点升级开始时间：<OTRS_TICKET_EscalationDestinationDate>
升级开始时间升级在：<OTRS_TICKET_EscalationDestinationIn>内

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (51, 12, 'text/plain', 'zh_CN', '工单升级警告Ticket Escalation Warning! <OTRS_TICKET_Title>', '您好  <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

票据工单 [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] 将升级！

升级地点升级开始时间：<OTRS_TICKET_EscalationDestinationDate>
升级开始时间升级在：<OTRS_TICKET_EscalationDestinationIn>内

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>


-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (52, 13, 'text/plain', 'zh_CN', '票据服务升级为工单服务更新为<OTRS_TICKET_Service>: <OTRS_TICKET_Title>', '您好 <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

票据服务工单服务 [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] 已被升级为已被更新为 <OTRS_TICKET_Service>。

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (53, 1, 'text/plain', 'pt_BR', 'Ticket criado: <OTRS_TICKET_Title>', 'Oi <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

o ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] foi criado na fila <OTRS_TICKET_Queue>.

<OTRS_CUSTOMER_REALNAME> escreveu:
<OTRS_CUSTOMER_BODY[30]>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (54, 2, 'text/plain', 'pt_BR', 'Acompanhamento do ticket desbloqueado: <OTRS_CUSTOMER_SUBJECT[24]>', 'Oi <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

o ticket desbloqueado [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] recebeu uma resposta.

<OTRS_CUSTOMER_REALNAME> escreveu:
<OTRS_CUSTOMER_BODY[30]>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (55, 3, 'text/plain', 'pt_BR', 'Acompanhamento do ticket bloqueado: <OTRS_CUSTOMER_SUBJECT[24]>', 'Oi <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

o ticket bloqueado [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] recebeu uma resposta.

<OTRS_CUSTOMER_REALNAME> escreveu:
<OTRS_CUSTOMER_BODY[30]>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (56, 4, 'text/plain', 'pt_BR', 'Tempo limite de bloqueio do ticket: <OTRS_TICKET_Title>', 'Oi <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

o ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] atingiu o seu período de tempo limite de bloqueio e agora está desbloqueado.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (57, 5, 'text/plain', 'pt_BR', 'Atualização de proprietário de ticket para <OTRS_OWNER_UserFullname>: <OTRS_TICKET_Title>', 'Oi <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

o proprietário do ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] foi atualizado para <OTRS_TICKET_OWNER_UserFullname> por <OTRS_CURRENT_UserFullname>.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (58, 6, 'text/plain', 'pt_BR', 'Atualização de responsável de ticket para <OTRS_RESPONSIBLE_UserFullname>: <OTRS_TICKET_Title>', 'Oi <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

o agente responsável do ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] foi atualizado para <OTRS_TICKET_RESPONSIBLE_UserFullname> por <OTRS_CURRENT_UserFullname>.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (59, 7, 'text/plain', 'pt_BR', 'Observação sobre o ticket: <OTRS_AGENT_SUBJECT[24]>', 'Oi <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

<OTRS_CURRENT_UserFullname> escreveu:
<OTRS_AGENT_BODY[30]>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (60, 8, 'text/plain', 'pt_BR', 'Atualização da fila do ticket para <OTRS_TICKET_Queue>: <OTRS_TICKET_Title>', 'Oi <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

o ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] foi atualizado na fila <OTRS_TICKET_Queue>.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (61, 9, 'text/plain', 'pt_BR', 'Tempo de Lembrete de Pendência do Ticket Bloqueado Atingido: <OTRS_TICKET_Title>', 'Oi <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

o tempo de lembrete pendente do ticket bloqueado [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] foi atingido.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (62, 10, 'text/plain', 'pt_BR', 'Tempo de Lembrete Pendente do Ticket Desbloqueado Atingido: <OTRS_TICKET_Title>', 'Oi <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

o tempo de lembrete pendente do ticket desbloqueado [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] foi atingido.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (63, 11, 'text/plain', 'pt_BR', 'Escalonamento do ticket! <OTRS_TICKET_Title>', 'Oi <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

o ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] foi escalonado!

Escalonado em: <OTRS_TICKET_EscalationDestinationDate>
Escalonado desde: <OTRS_TICKET_EscalationDestinationIn>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (64, 12, 'text/plain', 'pt_BR', 'Aviso de escalonamento do ticket! <OTRS_TICKET_Title>', 'Oi <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

o ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] será escalonado!

Escalonamento em: <OTRS_TICKET_EscalationDestinationDate>
Escalonamento em: <OTRS_TICKET_EscalationDestinationIn>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>


-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (65, 13, 'text/plain', 'pt_BR', 'Atualização do serviço do ticket para <OTRS_TICKET_Service>: <OTRS_TICKET_Title>', 'Oi <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

o serviço do ticket [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] foi atualizado para <OTRS_TICKET_Service>.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (66, 1, 'text/plain', 'hu', 'Jegy létrehozva: <OTRS_TICKET_Title>', 'Kedves <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>!

A(z) [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] jegy létrejött a következő várólistában: <OTRS_TICKET_Queue>.

<OTRS_CUSTOMER_REALNAME> ezt írta:
<OTRS_CUSTOMER_BODY[30]>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (67, 2, 'text/plain', 'hu', 'Feloldott jegy követése: <OTRS_CUSTOMER_SUBJECT[24]>', 'Kedves <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>!

A feloldott [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] jegy egy követő üzenetet kapott.

<OTRS_CUSTOMER_REALNAME> ezt írta:
<OTRS_CUSTOMER_BODY[30]>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (68, 3, 'text/plain', 'hu', 'Zárolt jegy követése: <OTRS_CUSTOMER_SUBJECT[24]>', 'Kedves <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>!

A zárolt [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] jegy egy követő üzenetet kapott.

<OTRS_CUSTOMER_REALNAME> ezt írta:
<OTRS_CUSTOMER_BODY[30]>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (69, 4, 'text/plain', 'hu', 'Jegyzár időkorlát: <OTRS_TICKET_Title>', 'Kedves <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>!

A(z) [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] jegy elérte a zárolás időkorlátjának időtartamát, és most feloldásra került.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (70, 5, 'text/plain', 'hu', 'Jegytulajdonos frissítés <OTRS_OWNER_UserLastname> <OTRS_OWNER_UserFirstname> ügyintézőre: <OTRS_TICKET_Title>', 'Kedves <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>!

A(z) [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] jegy tulajdonosát <OTRS_CURRENT_UserLastname> <OTRS_CURRENT_UserFirstname> frissítette <OTRS_OWNER_UserLastname> <OTRS_OWNER_UserFirstname> ügyintézőre.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (71, 6, 'text/plain', 'hu', 'Jegyfelelős frissítés <OTRS_RESPONSIBLE_UserLastname> <OTRS_RESPONSIBLE_UserFirstname> ügyintézőre: <OTRS_TICKET_Title>', 'Kedves <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>!

A(z) [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] jegy felelős ügyintézőjét <OTRS_CURRENT_UserLastname> <OTRS_CURRENT_UserFirstname> frissítette <OTRS_RESPONSIBLE_UserLastname> <OTRS_RESPONSIBLE_UserFirstname> ügyintézőre.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (72, 7, 'text/plain', 'hu', 'Új jegyzet: <OTRS_AGENT_SUBJECT[24]>', 'Kedves <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>!

<OTRS_CURRENT_UserLastname> <OTRS_CURRENT_UserFirstname> ezt írta:
<OTRS_AGENT_BODY[30]>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (73, 8, 'text/plain', 'hu', 'Jegy várólista frissítés <OTRS_TICKET_Queue> várólistára: <OTRS_TICKET_Title>', 'Kedves <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>!

A(z) [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] jegyet áthelyezték a következő várólistába: <OTRS_TICKET_Queue>.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (74, 9, 'text/plain', 'hu', 'Zárolt jegy „emlékeztető függőben” ideje elérve: <OTRS_TICKET_Title>', 'Kedves <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>!

A zárolt [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] jegy elérte az „emlékeztető függőben” idejét.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (75, 10, 'text/plain', 'hu', 'Feloldott jegy „emlékeztető függőben” ideje elérve: <OTRS_TICKET_Title>', 'Kedves <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>!

A feloldott [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] jegy elérte az „emlékeztető függőben” idejét.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (76, 11, 'text/plain', 'hu', 'Jegyeszkaláció! <OTRS_TICKET_Title>', 'Kedves <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>!

A(z) [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] jegy eszkalálódott!

Eszkaláció időpontja: <OTRS_TICKET_EscalationDestinationDate>
Eszkaláció óta eltelt idő: <OTRS_TICKET_EscalationDestinationIn>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (77, 12, 'text/plain', 'hu', 'Jegyeszkaláció figyelmeztetés! <OTRS_TICKET_Title>', 'Kedves <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>!

A(z) [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] jegy eszkalálódni fog!

Eszkaláció időpontja: <OTRS_TICKET_EscalationDestinationDate>
Eszkalációig fennmaradó idő: <OTRS_TICKET_EscalationDestinationIn>

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>


-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (id, notification_id, content_type, language, subject, text)
    VALUES
    (78, 13, 'text/plain', 'hu', 'Jegyszolgáltatás frissítve <OTRS_TICKET_Service> szolgáltatásra: <OTRS_TICKET_Title>', 'Kedves <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>!

A(z) [<OTRS_CONFIG_Ticket::Hook><OTRS_CONFIG_Ticket::HookDivider><OTRS_TICKET_TicketNumber>] jegy szolgáltatása frissítve lett a következőre: <OTRS_TICKET_Service>.

<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

-- <OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (1, 'text/plain', 'pl', 'Nowe zgłoszenie (<OTRS_CUSTOMER_SUBJECT[50]>)', 'Witaj <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

W kolejce "<OTRS_TICKET_Queue>" pojawiło się nowe zgłoszenie <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET_TicketNumber>.

Zgłoszenie możesz obsłużyć na stronie:
<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

<OTRS_CONFIG_NotificationSenderName>

________________________________

Od: <OTRS_CUSTOMER_From>
Temat: <OTRS_CUSTOMER_SUBJECT>

Fragment otrzymanej wiadomości:
<OTRS_CUSTOMER_BODY[30]>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (2, 'text/plain', 'pl', 'Nowa wiadomość do odblokowanego zgłoszenia (<OTRS_CUSTOMER_SUBJECT[50]>)', 'Witaj <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

Pojawiła się nowa wiadomość do odblokowanego zgłoszenia <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET_TicketNumber>.

Zgłoszenie możesz obsłużyć na stronie:
<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

<OTRS_CONFIG_NotificationSenderName>

________________________________

Od: <OTRS_CUSTOMER_From>
Temat: <OTRS_CUSTOMER_SUBJECT>

Fragment otrzymanej wiadomości:
<OTRS_CUSTOMER_BODY[30]>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (3, 'text/plain', 'pl', 'Nowa wiadomość do zablokowanego zgłoszenia (<OTRS_CUSTOMER_SUBJECT[50]>)', 'Witaj <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

Pojawiła się nowa wiadomość do zablokowanego zgłoszenia <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET_TicketNumber>.

Zgłoszenie możesz obsłużyć na stronie:
<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

<OTRS_CONFIG_NotificationSenderName>

________________________________

Od: <OTRS_CUSTOMER_From>
Temat: <OTRS_CUSTOMER_SUBJECT>

Fragment otrzymanej wiadomości:
<OTRS_CUSTOMER_BODY[30]>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (4, 'text/plain', 'pl', 'Odblokowanie zgłoszenia (<OTRS_CUSTOMER_SUBJECT[50]>)', 'Witaj <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

Przypisane do ciebie zgłoszenie <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET_TicketNumber>, znajdujące się w kolejce "<OTRS_TICKET_Queue>" zostało odblokowane.

Zgłoszenie możesz obsłużyć na stronie:
<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

<OTRS_CONFIG_NotificationSenderName>

________________________________

Od: <OTRS_CUSTOMER_From>
Temat: <OTRS_CUSTOMER_SUBJECT>

Fragment otrzymanej wiadomości:
<OTRS_CUSTOMER_BODY[30]>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (5, 'text/plain', 'pl', 'Przypisanie zgłoszenia (<OTRS_CUSTOMER_SUBJECT[50]>)', 'Witaj <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

<OTRS_CURRENT_UserFirstname> <OTRS_CURRENT_UserLastname> przydzielił(a) tobie zgłoszenie <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET_TicketNumber>.

Komentarz:
<OTRS_AGENT_BODY>

Zgłoszenie możesz obsłużyć na stronie:
<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

<OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (6, 'text/plain', 'pl', 'Przypisanie odpowiedzialności za zgłoszenie (<OTRS_CUSTOMER_SUBJECT[50]>)', 'Witaj <OTRS_RESPONSIBLE_UserFirstname>,

<OTRS_CURRENT_UserFirstname> <OTRS_CURRENT_UserLastname> wskazał ciebie jako osobę odpowiedzialną za zgłoszenie <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET_TicketNumber>.

Komentarz:
<OTRS_AGENT_BODY>

Zgłoszenie znajduje się na stronie:
<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

<OTRS_CONFIG_NotificationSenderName>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (7, 'text/plain', 'pl', 'Nowa notatka do zgłoszenia (<OTRS_CUSTOMER_SUBJECT[50]>)', 'Witaj <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

<OTRS_CURRENT_UserFirstname> <OTRS_CURRENT_UserLastname> dodał(a) nową notatkę do zgłoszenia <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET_TicketNumber>.

Treść notatki:
<OTRS_AGENT_BODY>

Zgłoszenie możesz obsłużyć na stronie:
<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

<OTRS_CONFIG_NotificationSenderName>

________________________________

Od: <OTRS_CUSTOMER_From>
Temat: <OTRS_CUSTOMER_SUBJECT>

Fragment otrzymanej wiadomości:
<OTRS_CUSTOMER_BODY[30]>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (8, 'text/plain', 'pl', 'Przeniesienie zgłoszenia (<OTRS_CUSTOMER_SUBJECT[50]>)', 'Witaj <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

Zgłoszenie <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET_TicketNumber> zostało przeniesione przez <OTRS_CURRENT_UserFirstname> <OTRS_CURRENT_UserLastname> do kolejki "<OTRS_CUSTOMER_QUEUE>".

Zgłoszenie możesz obsłużyć na stronie:
<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

<OTRS_CONFIG_NotificationSenderName>

________________________________

Od: <OTRS_CUSTOMER_From>
Temat: <OTRS_CUSTOMER_SUBJECT>

Fragment otrzymanej wiadomości:
<OTRS_CUSTOMER_BODY[30]>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (9, 'text/plain', 'pl', 'Przypomnienie o zablokowanym zgłoszeniu (<OTRS_CUSTOMER_SUBJECT[50]>)', 'Witaj <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

W kolejce "<OTRS_TICKET_Queue>" znajduje się zablokowane zgłoszenie <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET_TicketNumber>, dla którego ustawiona została wysyłka tego przypomnienia.

Zgłoszenie możesz obsłużyć na stronie:
<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

<OTRS_CONFIG_NotificationSenderName>

________________________________

Od: <OTRS_CUSTOMER_From>
Temat: <OTRS_CUSTOMER_SUBJECT>

Fragment otrzymanej wiadomości:
<OTRS_CUSTOMER_BODY[30]>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (10, 'text/plain', 'pl', 'Przypomnienie o odblokowanym zgłoszeniu (<OTRS_CUSTOMER_SUBJECT[50]>)', 'Witaj <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

W kolejce "<OTRS_TICKET_Queue>" znajduje się odblokowane zgłoszenie <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET_TicketNumber>, dla którego ustawiona została wysyłka tego przypomnienia.

Zgłoszenie możesz obsłużyć na stronie:
<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

<OTRS_CONFIG_NotificationSenderName>

________________________________

Od: <OTRS_CUSTOMER_From>
Temat: <OTRS_CUSTOMER_SUBJECT>

Fragment otrzymanej wiadomości:
<OTRS_CUSTOMER_BODY[30]>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (11, 'text/plain', 'pl', 'Eskalacja zgłoszenia (<OTRS_CUSTOMER_SUBJECT[50]>)', 'Witaj <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

Zgłoszenie <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET_TicketNumber> jest eskalowane.

Zgłoszenie możesz obsłużyć na stronie:
<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

<OTRS_CONFIG_NotificationSenderName>

________________________________

Od: <OTRS_CUSTOMER_From>
Temat: <OTRS_CUSTOMER_SUBJECT>

Fragment otrzymanej wiadomości:
<OTRS_CUSTOMER_BODY[30]>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (12, 'text/plain', 'pl', 'Ostrzeżenie przed eskalacją zgłoszenia (<OTRS_CUSTOMER_SUBJECT[50]>)', 'Witaj <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

Zgłoszenie <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET_TicketNumber> będzie wkrótce eskalowane.

Data eskalacji: <OTRS_TICKET_EscalationDestinationDate>
Eskalacja za:   <OTRS_TICKET_EscalationDestinationIn>

Zgłoszenie możesz obsłużyć na stronie:
<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

<OTRS_CONFIG_NotificationSenderName>

________________________________

Od: <OTRS_CUSTOMER_From>
Temat: <OTRS_CUSTOMER_SUBJECT>

Fragment otrzymanej wiadomości:
<OTRS_CUSTOMER_BODY[30]>');
# ----------------------------------------------------------
#  insert into table notification_event_message
# ----------------------------------------------------------
INSERT INTO notification_event_message (notification_id, content_type, language, subject, text)
    VALUES
    (13, 'text/plain', 'pl', 'Zmiana usługi w zgłoszeniu (<OTRS_CUSTOMER_SUBJECT[50]>)', 'Witaj <OTRS_NOTIFICATION_RECIPIENT_UserFirstname>,

W zgłoszeniu <OTRS_CONFIG_Ticket::Hook><OTRS_TICKET_TicketNumber> <OTRS_CURRENT_UserFirstname> <OTRS_CURRENT_UserLastname> zmienił(a) usługę na <OTRS_TICKET_Service>.

Zgłoszenie możesz obsłużyć na stronie:
<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom\;TicketID=<OTRS_TICKET_TicketID>

<OTRS_CONFIG_NotificationSenderName>

________________________________

Od: <OTRS_CUSTOMER_From>
Temat: <OTRS_CUSTOMER_SUBJECT>

Fragment otrzymanej wiadomości:
<OTRS_CUSTOMER_BODY[30]>');
# ----------------------------------------------------------
#  insert into table dynamic_field
# ----------------------------------------------------------
INSERT INTO dynamic_field (id, internal_field, name, label, field_order, field_type, object_type, config, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (1, 1, 'ProcessManagementProcessID', 'Process', 1, 'ProcessID', 'Ticket', '---
DefaultValue: \'\'
', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table dynamic_field
# ----------------------------------------------------------
INSERT INTO dynamic_field (id, internal_field, name, label, field_order, field_type, object_type, config, valid_id, create_by, create_time, change_by, change_time)
    VALUES
    (2, 1, 'ProcessManagementActivityID', 'Activity', 1, 'ActivityID', 'Ticket', '---
DefaultValue: \'\'
', 1, 1, current_timestamp, 1, current_timestamp);
# ----------------------------------------------------------
#  insert into table counter
# ----------------------------------------------------------
INSERT INTO counter (id, name, value, create_by, create_time, change_by, change_time)
    VALUES
    (1, 'TicketNumber', 0, 1, current_timestamp, 1, current_timestamp);
