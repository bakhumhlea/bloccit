module SponsoredPostsHelper
    def user_is_authorized_for_post?(sponsored_post)
        current_user && (current_user == sponsored_post.user || current_user.admin?)
    end
    def moderator_authorized_for_post?(sponsored_post)
        current_user && (current_user == sponsored_post.user || current_user.moderator?)
    end
end
