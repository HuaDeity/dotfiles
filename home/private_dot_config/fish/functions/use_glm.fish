function use_glm --description "Set or unset environment variables for GLM or Claude"
    set -l managed_vars ANTHROPIC_AUTH_TOKEN ANTHROPIC_BASE_URL API_TIMEOUT_MS CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC

    if test "$argv[1]" = unset
        for var in $managed_vars
            set -l backup_var "__use_glm_backup_$var"
            if set -q $backup_var
                set $backup_var | read -l backup_value
                if test "$backup_value" = __none__
                    set -e $var
                else
                    set -gx $var "$backup_value"
                end
                set -e $backup_var
            else
                set -e $var
            end
        end
        echo "Reverted GLM/Claude environment variables"
        return
    end

    for var in $managed_vars
        set -l backup_var "__use_glm_backup_$var"
        if not set -q $backup_var
            if set -q $var
                set $var | read -l original_value
                set -g $backup_var "$original_value"
            else
                set -g $backup_var __none__
            end
        end
    end

    if test "$argv[1]" = claude
        set -gx ANTHROPIC_AUTH_TOKEN $ZAI_API_KEY
        set -gx ANTHROPIC_BASE_URL "https://api.anthropic.com/v1"
        set -gx API_TIMEOUT_MS 3000000
        set -gx CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC 1
        echo "Set Claude (direct) environment variables. You may need to set ANTHROPIC_AUTH_TOKEN."
    else
        set -gx ANTHROPIC_AUTH_TOKEN $ZAI_API_KEY
        set -gx ANTHROPIC_BASE_URL "https://open.bigmodel.cn/api/anthropic"
        set -gx API_TIMEOUT_MS 3000000
        set -gx CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC 1
        echo "Set GLM (Zhipu proxy for Claude) environment variables"
    end
end
