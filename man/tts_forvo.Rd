% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tts_forvo.R
\name{tts_forvo}
\alias{tts_forvo}
\title{Download audios from the Forvo API}
\usage{
tts_forvo(
  words,
  language_code,
  language,
  output_dir,
  sex = "",
  country = "",
  order = "rate-desc",
  group_in_languages = "false",
  username = "",
  rate = "",
  limit = "",
  key = "d743942e785bf673c4c64e0a6da0ebf5",
  action = "word-pronunciations",
  format = "json"
)
}
\arguments{
\item{words}{vector of strings with the words to download as audios}

\item{language_code}{language code of the audios, check https://forvo.com/languages-codes/}

\item{language}{name of the language, used to generate the names of the audio files,
e.g. "french"}

\item{output_dir}{directory where the audios will be saved}

\item{sex}{"m" for male, "f" for female}

\item{format}{}
}
\value{

}
\description{
Download the audios of the words using Forvo API. The information about most of
the arguments comes from the API itself, and all those arguments must be \emph{strings},
if you don't want to use an optional argument leave it empty (\code{""}).
}
\examples{
tts_forvo("bonjour", "fr", "french", "C:/Users/NAPO/Downloads")

}
