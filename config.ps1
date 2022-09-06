
docker pull tootsuite/mastodon

$conf = ".\.balena\secrets\.env.production" 
$vars = @{}

$secret = {docker run --rm tootsuite/mastodon bundle exec /opt/ruby/bin/rake secret}

$vars["SECRET_KEY_BASE"]= & $secret
$vars["OTP_SECRET"]= & $secret

$vapids = docker run --rm tootsuite/mastodon bundle exec /opt/ruby/bin/rake mastodon:webpush:generate_vapid_key

$vars = $vars + ($vapids -join "`n" |  ConvertFrom-StringData)

$data = Get-Content -raw $conf
foreach($key in $vars.Keys) {
    $data = $data -replace "(?im)^$key=.*", "$key=$($vars[$key])"
}
Set-Content $conf $data

Write-Output "Done generating secrets in $conf"