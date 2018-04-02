open Core
open Lwt
open Cohttp
open Cohttp_lwt_unix

let getRepo =
  let headers =
    Cohttp.Header.init_with "User-Agent" "cohttp"
  in
  let request = Uri.of_string "https://api.github.com/repos/octokit/octokit.rb"
                |> Cohttp_lwt_unix.Client.get ~headers: headers
  in
  request >>=
    (fun (resp, body) ->
      let code = resp |> Response.status |> Code.code_of_status in
      let headers = resp |> Response.headers |> Header.to_string in
      Cohttp_lwt.Body.to_string body >|=
        (fun body ->
          Repo_j.repo_of_string body
    ))
