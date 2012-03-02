module RedmineProjectSpecificEmailSender
  module MailHandlerPatch
    
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        alias_method_chain :receive_issue, :project_specific_email
      end
    end
    
    module InstanceMethods
      def receive_issue_with_project_specific_email
        receive_issue_without_project_specific_email if @email.to_addrs.map(&:spec).include? target_project.email
      end
    end
  end
end
