-module(marvin_pdu_object).
-include("marvin_discord.hrl").
-include("marvin_pdu_object.hrl").



%% Callbacks



-callback new(Data :: term() | undefined) ->
    Ret :: object().

-callback data_map() ->
    jiffy_vm:jv_type().

-callback export(PDU :: object()) ->
    marvin_helper_type:generic_return(
        OkRet :: term() | undefined,
        ErrorRet :: term()
    ).



%% Types



-type object_impl() ::
    marvin_pdu_object_user:object().
-type object() :: ?marvin_pdu_object(Mod :: atom(), PDU :: object_impl()).
-export_type([object/0]).



%% Interface



%% Internals
