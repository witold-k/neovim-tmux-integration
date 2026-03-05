local pl_path = require "pl.path"
local pl_List = require "pl.List"
local python_path = nil
local docker_path = nil
local docker_type = nil
local home = pl_path.expanduser("~")

--

local function exists(path)
    if path == nil then return false end

    -- File?
    local f = io.open(path, "r")
    if f then
        f:close()
        return true
    end

    -- Directory? (Try open "." inside)
    local d = io.open(path .. "/.", "r")
    if d then
        d:close()
        return true
    end

    return false
end

local function which(pathl, file)
    local res = pathl:map(pl_path.join,file)
    res = res:filter(pl_path.exists)
    if res then return res[1] end
end

local function append_home_exists(path, check)
    local cpath = home .. check
    if exists(cpath) then
        if path == nil then
            return cpath
        else
            return cpath .. ':' .. path
        end
    else
        return path
    end
end

--

python_path = append_home_exists(python_path, '/svn/buildscripts/python')
python_path = append_home_exists(python_path, '/repos/buildscripts/python')
python_path = append_home_exists(python_path, '/repos/common-scripts/python')
python_path = append_home_exists(python_path, '/depots/common-scripts/python')

if docker_path == nil then
    local path = '/usr/bin/docker'
    if exists(path) then
        docker_path = path
        docker_type = 'docker'
    end
end

if docker_path == nil then
    local path = '/usr/bin/podman'
    if exists(path) then
        docker_path = path
        docker_type = 'podman'
    end
end

local pathl = pl_List.split(os.getenv 'PATH', pl_path.dirsep)
local config = {
    goproxy = 'https://goproxy.io,direct',
    python_path = python_path,
    docker_path = docker_path,
    docker_type = docker_type,
    image       = 'ubuntu',
    path        = pathl,
    nvim_path   = which(pathl, "nvim"),
}

local goproxy_env = 'GOPROXY=https://goproxy.io,direct'
local curl_ca_env = 'CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt'
local ssl_cert_env = 'SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt'
local python_path_env = 'PYTHONPATH=' .. python_path

return {
    config = config,
    vars = {
        goproxy_env = goproxy_env,
        curl_ca_env = curl_ca_env,
        ssl_cert_env = ssl_cert_env,
        python_path_env = python_path_env,
    },
    env = curl_ca_env .. ' ' .. ssl_cert_env .. ' ' .. goproxy_env .. ' ' .. python_path_env,
    eenv = '-e ' .. curl_ca_env .. ' -e ' .. ssl_cert_env .. ' -e ' .. goproxy_env .. ' -e ' .. python_path_env,
    exists = exists,
    which = which
}

