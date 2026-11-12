-- DAFZZ Sky - Fresh Sky V2 - iPad/Delta (SKY ONLY)

local W,A=writefile,getcustomasset or getsynasset
if not(W and A)then warn("custom asset APIs missing")return end

local function get(n,u)
    local ok,r=pcall(function()
        W(n,game:HttpGet(u))
        return A(n)
    end)
    if ok then return r end
    warn(r)
end

local U={
    ft="https://raw.githubusercontent.com/louisvilleabsalon8-hue/idk/refs/heads/main/64CAA0DD-21DA-4DA8-8F3F-CE3AF36C6B01.png",
    lf="https://raw.githubusercontent.com/louisvilleabsalon8-hue/dafzzz-gay-sky/refs/heads/main/sky512_lf.png",
    rt="https://raw.githubusercontent.com/louisvilleabsalon8-hue/dafzzz-gay-sky/refs/heads/main/sky512_rt.png",
    dn="https://raw.githubusercontent.com/louisvilleabsalon8-hue/dafzzz-gay-sky/refs/heads/main/sky512_dn.png",
    bk="https://raw.githubusercontent.com/louisvilleabsalon8-hue/dafzzz-gay-sky/refs/heads/main/sky512_bk.png",
    up="https://raw.githubusercontent.com/louisvilleabsalon8-hue/dafzzz-gay-sky/refs/heads/main/sky512_up.png",
}

local P={
    bk="SkyboxBk",
    dn="SkyboxDn",
    ft="SkyboxFt",
    lf="SkyboxLf",
    rt="SkyboxRt",
    up="SkyboxUp"
}

local SA={}

for _,f in ipairs({"bk","dn","ft","lf","rt","up"}) do
    SA[f]=get("dafzzz_"..f..".png",U[f])
    task.wait(.12)
end

local L=game:GetService("Lighting")
local creating=false

local function freshSky()
    if creating then return end
    creating=true

    for _,v in ipairs(L:GetChildren()) do
        if v:IsA("Sky") then
            pcall(function()v:Destroy()end)
        end
    end

    local x=Instance.new("Sky")
    x.Name="DAFZZSky"

    for f,a in pairs(SA) do
        if a then
            pcall(function()
                x[P[f]]=a
            end)
        end
    end

    x.Parent=L
    creating=false
end

freshSky()

for _,t in ipairs({.5,1.5,3,6,10}) do
    task.delay(t,freshSky)
end

local last=0

L.ChildAdded:Connect(function(x)
    if x:IsA("Sky") and x.Name~="DAFZZSky" then
        local now=os.clock()
        if now-last>.5 then
            last=now
            task.delay(.15,freshSky)
        end
    end
end)
