module ApplicationHelper
    def user_profile_background_class
        if (controller_name == 'users' && action_name == 'profil') ||
            (controller_name == 'users' && action_name == 'settings') ||
            (controller_path == 'registrations' && action_name == 'edit')
            'bg-TapCard-teal'
        else
        'bg-TapCard-charcoal' 
        end
    end
end
