local Players = game:GetService('Players')
local TweenService = game:GetService('TweenService')
local CoreGui = game:GetService('CoreGui')
local MarketplaceService = game:GetService('MarketplaceService')

local LocalPlayer = Players.LocalPlayer
local ProtectGui = protectgui or (syn and syn.protect_gui) or function() end

local Library = {
    Font = Enum.Font.Gotham,
    FontMedium = Enum.Font.GothamMedium,
    FontBold = Enum.Font.GothamBold,
    MainColor = Color3.fromRGB(12, 14, 18),
    SurfaceColor = Color3.fromRGB(17, 20, 26),
    SurfaceColor2 = Color3.fromRGB(22, 26, 34),
    AccentColor = Color3.fromRGB(77, 166, 255),
    AccentColor2 = Color3.fromRGB(35, 105, 190),
    OutlineColor = Color3.fromRGB(38, 50, 66),
    TextColor = Color3.fromRGB(232, 237, 245),
    MutedTextColor = Color3.fromRGB(143, 153, 170),
    SuccessColor = Color3.fromRGB(90, 220, 145),
}

function Library:Create(Class, Properties)
    local Object = Instance.new(Class)
    for Property, Value in pairs(Properties or {}) do
        Object[Property] = Value
    end
    return Object
end

function Library:CreateLabel(Properties)
    Properties = Properties or {}
    Properties.BackgroundTransparency = Properties.BackgroundTransparency or 1
    Properties.Font = Properties.Font or Library.Font
    Properties.TextColor3 = Properties.TextColor3 or Library.TextColor
    Properties.TextSize = Properties.TextSize or 14
    Properties.TextStrokeTransparency = 1
    Properties.TextXAlignment = Properties.TextXAlignment or Enum.TextXAlignment.Left
    Properties.TextYAlignment = Properties.TextYAlignment or Enum.TextYAlignment.Center
    return Library:Create('TextLabel', Properties)
end

function Library:AddCorner(Parent, Radius)
    return Library:Create('UICorner', {
        CornerRadius = UDim.new(0, Radius or 6),
        Parent = Parent,
    })
end

function Library:AddStroke(Parent, Color, Thickness, Transparency)
    return Library:Create('UIStroke', {
        Color = Color or Library.OutlineColor,
        Thickness = Thickness or 1,
        Transparency = Transparency or 0,
        Parent = Parent,
    })
end

function Library:Tween(Object, Properties, Time)
    local Tween = TweenService:Create(
        Object,
        TweenInfo.new(Time or 0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        Properties
    )
    Tween:Play()
    return Tween
end

local function getGameName()
    local name = 'Hood Custom'
    pcall(function()
        local info = MarketplaceService:GetProductInfo(game.PlaceId)
        if type(info.Name) == 'string' and info.Name ~= '' then
            name = info.Name
        end
    end)
    return name
end

local function readEnchantSource()
    if readfile and isfile then
        if isfile('Enchant.lua') then
            return readfile('Enchant.lua')
        end
        if isfile('./Enchant.lua') then
            return readfile('./Enchant.lua')
        end
    end

    if loadfile then
        local ok, result = pcall(loadfile, 'Enchant.lua')
        if ok and type(result) == 'function' then
            return result, true
        end
    end
end

local ScreenGui = Library:Create('ScreenGui', {
    Name = 'EnchantLoader',
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Global,
})
ProtectGui(ScreenGui)
ScreenGui.Parent = CoreGui

local Window = Library:Create('Frame', {
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Library.MainColor,
    BorderSizePixel = 0,
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(650, 390),
    Parent = ScreenGui,
})
Library:AddCorner(Window, 8)
Library:AddStroke(Window, Library.AccentColor, 1, 0)

Library:Create('Frame', {
    BackgroundColor3 = Library.AccentColor,
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(8, 8),
    Size = UDim2.new(1, -16, 0, 2),
    Parent = Window,
})

local Header = Library:Create('Frame', {
    BackgroundColor3 = Library.SurfaceColor,
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(8, 12),
    Size = UDim2.new(1, -16, 0, 62),
    Parent = Window,
})
Library:AddCorner(Header, 6)

Library:CreateLabel({
    Font = Library.FontBold,
    Position = UDim2.fromOffset(18, 0),
    Size = UDim2.new(0.5, 0, 1, 0),
    Text = 'Enchant.lua',
    TextColor3 = Library.TextColor,
    TextSize = 25,
    Parent = Header,
})

Library:CreateLabel({
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, -72, 0, 0),
    Size = UDim2.fromOffset(230, 62),
    Text = getGameName(),
    TextColor3 = Library.MutedTextColor,
    TextSize = 15,
    TextXAlignment = Enum.TextXAlignment.Right,
    TextTruncate = Enum.TextTruncate.AtEnd,
    Parent = Header,
})

local Avatar = Library:Create('ImageLabel', {
    AnchorPoint = Vector2.new(1, 0.5),
    BackgroundColor3 = Library.SurfaceColor2,
    BorderSizePixel = 0,
    Image = string.format('rbxthumb://type=AvatarHeadShot&id=%s&w=100&h=100', tostring(LocalPlayer.UserId)),
    Position = UDim2.new(1, -18, 0.5, 0),
    Size = UDim2.fromOffset(40, 40),
    Parent = Header,
})
Library:AddCorner(Avatar, 20)
Library:AddStroke(Avatar, Library.AccentColor, 1, 0.15)

local LeftPanel = Library:Create('Frame', {
    BackgroundColor3 = Library.SurfaceColor,
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(22, 92),
    Size = UDim2.fromOffset(290, 226),
    Parent = Window,
})
Library:AddCorner(LeftPanel, 7)
Library:AddStroke(LeftPanel, Library.OutlineColor, 1, 0)

Library:CreateLabel({
    Font = Library.FontBold,
    Position = UDim2.fromOffset(18, 14),
    Size = UDim2.new(1, -36, 0, 26),
    Text = 'Roblox Game',
    TextSize = 18,
    Parent = LeftPanel,
})

Library:CreateLabel({
    Position = UDim2.fromOffset(18, 42),
    Size = UDim2.new(1, -36, 0, 22),
    Text = 'Products: 1',
    TextColor3 = Library.MutedTextColor,
    TextSize = 13,
    Parent = LeftPanel,
})

local Product = Library:Create('Frame', {
    BackgroundColor3 = Color3.fromRGB(10, 12, 16),
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(16, 82),
    Size = UDim2.new(1, -32, 0, 86),
    Parent = LeftPanel,
})
Library:AddCorner(Product, 6)
Library:AddStroke(Product, Color3.fromRGB(24, 34, 48), 1, 0)

Library:Create('Frame', {
    BackgroundColor3 = Library.AccentColor,
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(10, 18),
    Size = UDim2.fromOffset(3, 50),
    Parent = Product,
})

Library:CreateLabel({
    Font = Library.FontBold,
    Position = UDim2.fromOffset(24, 12),
    Size = UDim2.new(1, -36, 0, 26),
    Text = 'Hood Custom',
    TextSize = 18,
    Parent = Product,
})

Library:CreateLabel({
    Position = UDim2.fromOffset(24, 43),
    Size = UDim2.fromOffset(150, 22),
    Text = 'Status: Online',
    TextColor3 = Library.SuccessColor,
    TextSize = 13,
    Parent = Product,
})

Library:CreateLabel({
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, -18, 0, 43),
    Size = UDim2.fromOffset(100, 22),
    Text = 'Enchant',
    TextColor3 = Library.MutedTextColor,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Right,
    Parent = Product,
})

Library:CreateLabel({
    Position = UDim2.fromOffset(18, 184),
    Size = UDim2.new(1, -36, 0, 24),
    Text = 'Selected script: Enchant.lua',
    TextColor3 = Library.MutedTextColor,
    TextSize = 13,
    Parent = LeftPanel,
})

local RightPanel = Library:Create('Frame', {
    BackgroundColor3 = Library.SurfaceColor,
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(332, 92),
    Size = UDim2.fromOffset(296, 226),
    Parent = Window,
})
Library:AddCorner(RightPanel, 7)
Library:AddStroke(RightPanel, Library.OutlineColor, 1, 0)

Library:CreateLabel({
    Font = Library.FontBold,
    Position = UDim2.fromOffset(18, 14),
    Size = UDim2.new(1, -36, 0, 26),
    Text = 'Information',
    TextSize = 18,
    Parent = RightPanel,
})

Library:Create('Frame', {
    BackgroundColor3 = Library.OutlineColor,
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(0, 54),
    Size = UDim2.new(1, 0, 0, 1),
    Parent = RightPanel,
})

Library:CreateLabel({
    Font = Library.Font,
    Position = UDim2.fromOffset(18, 70),
    Size = UDim2.new(1, -36, 0, 88),
    Text = '- Hood Custom support\n- Blue Enchant UI style\n- Loads local Enchant.lua\n- Uses Enchant UI-library style parts',
    TextColor3 = Color3.fromRGB(199, 206, 218),
    TextSize = 14,
    TextWrapped = true,
    TextYAlignment = Enum.TextYAlignment.Top,
    Parent = RightPanel,
})

Library:CreateLabel({
    Position = UDim2.fromOffset(18, 164),
    Size = UDim2.fromOffset(120, 22),
    Text = 'Access:',
    TextSize = 14,
    Parent = RightPanel,
})

Library:CreateLabel({
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, -18, 0, 164),
    Size = UDim2.fromOffset(140, 22),
    Text = 'Buyer',
    TextColor3 = Library.AccentColor,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Right,
    Parent = RightPanel,
})

local Status = Library:CreateLabel({
    Position = UDim2.fromOffset(24, 328),
    Size = UDim2.new(1, -48, 0, 22),
    Text = '',
    TextColor3 = Library.AccentColor,
    TextSize = 13,
    Parent = Window,
})

local ExitButton = Library:Create('TextButton', {
    AutoButtonColor = false,
    BackgroundColor3 = Library.SurfaceColor2,
    BorderSizePixel = 0,
    Font = Library.FontMedium,
    Position = UDim2.fromOffset(332, 340),
    Size = UDim2.fromOffset(138, 34),
    Text = 'Exit',
    TextColor3 = Library.MutedTextColor,
    TextSize = 14,
    TextStrokeTransparency = 1,
    Parent = Window,
})
Library:AddCorner(ExitButton, 6)
Library:AddStroke(ExitButton, Library.OutlineColor, 1, 0)

local LoadButton = Library:Create('TextButton', {
    AutoButtonColor = false,
    BackgroundColor3 = Library.AccentColor2,
    BorderSizePixel = 0,
    Font = Library.FontBold,
    Position = UDim2.fromOffset(490, 340),
    Size = UDim2.fromOffset(138, 34),
    Text = 'Load',
    TextColor3 = Library.TextColor,
    TextSize = 14,
    TextStrokeTransparency = 1,
    Parent = Window,
})
Library:AddCorner(LoadButton, 6)
Library:AddStroke(LoadButton, Library.AccentColor, 1, 0.15)

local function wireHover(Object, BaseColor, HoverColor)
    Object.MouseEnter:Connect(function()
        Library:Tween(Object, { BackgroundColor3 = HoverColor }, 0.12)
    end)
    Object.MouseLeave:Connect(function()
        Library:Tween(Object, { BackgroundColor3 = BaseColor }, 0.12)
    end)
end

wireHover(ExitButton, Library.SurfaceColor2, Color3.fromRGB(30, 35, 45))
wireHover(LoadButton, Library.AccentColor2, Library.AccentColor)

ExitButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

LoadButton.MouseButton1Click:Connect(function()
    Status.Text = 'Loading Enchant.lua...'

    local sourceOrFunction, isFunction = readEnchantSource()
    if isFunction and type(sourceOrFunction) == 'function' then
        ScreenGui:Destroy()
        return task.spawn(sourceOrFunction)
    end

    if type(sourceOrFunction) ~= 'string' then
        Status.Text = 'Could not find Enchant.lua next to this loader.'
        return
    end

    local fn, err = loadstring(sourceOrFunction)
    if type(fn) ~= 'function' then
        Status.Text = 'Load error: ' .. tostring(err)
        return
    end

    ScreenGui:Destroy()
    task.spawn(fn)
end)
