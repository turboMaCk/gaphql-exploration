open Core
open Lwt
open Cohttp
open Cohttp_lwt_unix

let body =
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
      Printf.printf "Response code: %d\n" code;
      Printf.printf "Headers: %s\n" headers;
      Cohttp_lwt.Body.to_string body >|=
        (fun body ->
          let repo = Repo_j.repo_of_string body in
          Printf.printf "Repo is here: %s\n" (Repo_j.string_of_repo repo);
          body
    ))

let () =
  Lwt_main.run body;
  exit 1;
