
import sys

def e(command):
    return os.popen(command).read()[:-1]

wikis = os.listdir('/usr/share/doc/arch-wiki/html/en/')

for i, wiki in enumerate(wikis):
    if wiki.find('.html') == -1:
        wikis.remove(wiki)
    else:
        wikis[i] = wiki.replace('.html', '')
        
wikis = sorted(wikis)


wiki = e('echo "{}" | rofi -dmenu -i -p "Wiki: " -theme-str "element-icon {{ enabled: false; }} listview {{ columns: 1; }}"'.format("\n".join(wikis)))

if wiki != '':
    wiki = '/usr/share/doc/arch-wiki/html/en/' + wiki + '.html'
    e('firefox ' + wiki)
