#!/bin/sh

echo
echo "Getting latest verion of Kind release"
echo
# This came from https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

KIND_LATEST_RELEASE=$(get_latest_release "kubernetes-sigs/kind")

echo "Latest release of kind is ${KIND_LATEST_RELEASE}"
echo "Downloading Kind release [${KIND_LATEST_RELEASE}] now"
echo
wget -q https://github.com/kubernetes-sigs/kind/releases/download/${KIND_LATEST_RELEASE}/kind-linux-amd64

if ( ls kind-linux-amd64 > /dev/null 2>&1 ); then
{
echo "Moving kind to it's location"
mv ./kind-linux-amd64 ./kind
chmod +x ./kind
mv ./kind /root/go/bin/kind

#source <(kind completion bash)

echo "Kind version is : $(kind version)"
}
else
{
echo "We failed to download kind";
}
 fi