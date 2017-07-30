-module(marvin_pdu_heartbeat_ack_tests).

-include("marvin_discord.hrl").
-include("marvin_pdu.hrl").
-include_lib("eunit/include/eunit.hrl").
-include_lib("marvin_helper/include/marvin_specs_tests.hrl").


-spec ?test_spec(test).

%% automatically generated by eunit


-spec ?test_spec(t01_can_get_new_test).

t01_can_get_new_test() ->
    marvin_pdu_heartbeat_ack:new().


-spec ?test_spec(t04_can_render_valid_opaque_test).

t04_can_render_valid_opaque_test() ->
    PDU0 = marvin_pdu_heartbeat_ack:new(100),
    ?assertMatch({ok, _Message}, marvin_pdu:render(PDU0)).


-spec ?test_spec(t99_can_get_valid_parsed_test).

t99_can_get_valid_parsed_test() ->
    {ok, JSONBin} = file:read_file(
        code:priv_dir(marvin_pdu) ++ "/marvin_pdu_heartbeat_ack_test.json"),
    ?assertMatch({ok, {?marvin_pdu_heartbeat_ack(_), undefined}}, marvin_pdu:parse(JSONBin)).
