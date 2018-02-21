--- === Micropub ===
---
--- Publish content to a Micropub endpoint. 

local obj={}
obj.__index = obj


-- Metadata
obj.name = "Micropub"
obj.version = "0.1.1"
obj.author = "Jonathan LaCour <jonathan@cleverdevil.org>"
obj.homepage = "https://github.com/cleverdevil/Micropub.spoon"
obj.license = "MIT - https://opensource.org/licenses/MIT"


--- Micropub.micropub_endpoint_url
--- Variable
--- The URL for your Micropub endpoint. 
obj.micropub_endpoint_url = ""


--- Micropub.micropub_token
--- Variable
--- A valid IndieAuth token with create/update scopes. 
obj.micropub_token = "" 


--- Micropub.logger
--- Variable
--- Logger object used within the Spoon. Can be accessed to set the default log level for the messages coming from the Spoon.
obj.logger = hs.logger.new('Micropub')


--- Micropub:publish(mf2)
--- Method
--- Publish to your Micropub endpoint. 
---
--- Parameters:
---  * mf2 - A microformat2-json representation of your content to publish.
---
--  Returns:
--   * None
function obj:publish(mf2)
    json_data = hs.json.encode(mf2)
    self.logger.wf("JSON: '%s'", json_data)
    headers = {
        Authorization = 'Bearer ' .. self.micropub_token,
        ['Content-Type'] = 'application/json'
    }
    local status,result,headerResponse = hs.http.post(
        self.micropub_endpoint_url,
        json_data,
        headers
    )
    self.logger.wf("Status: '%d'", status)
    self.logger.wf("Result: '%s'", result)
end


--- Micropub:publishNote(note)
--- Method
--- Publish a plain text note to your Micropub endpoint. 
---
--- Parameters:
---  * note - A plain text note.
--- 
--- Returns:
---  * None
function obj:publishNote(note)
    self:publish({
        type = {'h-entry'},
        properties = {
            content = { note }
        }
    })
end


--- Micropub:publishPost(title, html_content)
--- Method
--- Publish an HTML post to your Micropub endpoint.
--- 
--- Parameters:
---  * title - The title of your post.
---  * html_content - the HTML content for your post.
--- 
--- Returns:
---  * None
function obj:publishPost(title, html_content)
    self:publish({
        type = {'h-entry'},
        properties = {
            content = { 
                { html = html_content }
            }
        }
    })
end


return obj
