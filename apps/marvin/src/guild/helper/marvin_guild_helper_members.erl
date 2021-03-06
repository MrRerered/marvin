-module(marvin_guild_helper_members).

-include("marvin_guild_state.hrl").

-export([
    w_do_provision/2,
    r_get_member_by_user_id/2
]).



%% Interface



-spec w_do_provision(Members :: [marvin_pdu2_object_member:t()], Ctx :: marvin_guild_context:t()) ->
    marvin_helper_type:ok_return().

w_do_provision(Members, Ctx) ->
    marvin_log:info("Guild '~s' members chunk: ~p total", [marvin_guild_context:guild_id(Ctx), length(Members)]),
    ets:insert(marvin_guild_context:member_state(Ctx), [#member{
        member_id = marvin_pdu2_object_user:id(marvin_pdu2_object_member:user(Member)),
        member = Member
    } || Member <- Members]),
    ok.



-spec r_get_member_by_user_id(UserId :: marvin_pdu2:snowflake(), Ctx :: marvin_guild_context:t()) ->
    Ret :: marvin_pdu2_object_member:t() | undefined.

r_get_member_by_user_id(UserId, Ctx) ->
    case ets:lookup(marvin_guild_context:member_state(Ctx), UserId) of
        [] ->
            undefined;
        [#member{member_id = UserId, member = Member}] ->
            Member
    end.
