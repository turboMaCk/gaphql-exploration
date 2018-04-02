open Core
open Lwt
open Cohttp
open Cohttp_lwt_unix

let get_repo =
  let headers =
    Cohttp.Header.init_with "User-Agent" "cohttp"
  in
  let request = Uri.of_string "https://api.github.com/repos/octokit/octokit.rb"
                |> Cohttp_lwt_unix.Client.get ~headers: headers
  in
  request >>=
    (fun (resp, body) ->
      Cohttp_lwt.Body.to_string body >|=
        (fun b ->
          Repo_j.repo_of_string b
    ))
