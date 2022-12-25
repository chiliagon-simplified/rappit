# frozen_string_literal: true

module AuthScopes
  IDENTITY = 'identity'
  EDIT = 'edit'
  FLAIR = 'flair'
  HISTORY = 'history'
  MODCONFIG = 'modconfig'
  MODFLAIR = 'modflair'
  MODLOG = 'modlog'
  MODPOSTS = 'modposts'
  MODWIKI = 'modwiki'
  MYSUBREDDITS = 'mysubreddits'
  PRIVATEMESSAGES = 'privatemessages'
  READ = 'read'
  REPORT = 'report'
  SAVE = 'save'
  SUBMIT = 'submit'
  SUBSCRIBE = 'subscribe'
  VOTE = 'vote'
  WIKIEDIT = 'wikiedit'
  WIKIREAD = 'wikiread'

  SCOPES = [IDENTITY, EDIT, FLAIR, HISTORY, MODCONFIG, MODFLAIR, MODLOG, MODPOSTS, MODWIKI, MYSUBREDDITS,
            PRIVATEMESSAGES, READ, REPORT, SAVE, SUBMIT, SUBSCRIBE, VOTE, WIKIEDIT, WIKIREAD].freeze
end

module AuthDurations
  TEMPORARY = 'temporary'
  PERMANENT = 'permanent' # default
end
