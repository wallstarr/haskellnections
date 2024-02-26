module WordGrids where

import Data.Map (Map)
import Data.Map qualified as Map
import Haskellnections

-- Credit -- ChatGPT generated some of these for us! We are appreciative.
wordGrids =
  [ WordGrid
      [ "Python",
        "Binary-Tree",
        "Bubble",
        "Declarative",
        "Bash",
        "Merge",
        "Object-Oriented",
        "Functional",
        "Insertion",
        "Linked-List",
        "Quick",
        "Imperative",
        "Groovy",
        "Stack",
        "Hash-Map",
        "Perl"
      ]
      [ ConnectionGroup (Connection "Python" "Perl" "Bash" "Groovy") "Scripting Languages",
        ConnectionGroup (Connection "Binary-Tree" "Linked-List" "Hash-Map" "Stack") "Data Structures",
        ConnectionGroup (Connection "Merge" "Quick" "Insertion" "Bubble") "Sorting Algorithms",
        ConnectionGroup (Connection "Object-Oriented" "Functional" "Imperative" "Declarative") "Programming Paradigms"
      ],
    WordGrid
      [ "SQL",
        "Android",
        "SSD",
        "Motherboard",
        "HTTP",
        "Windows",
        "macOS",
        "GPU",
        "Redis",
        "TCP",
        "Linux",
        "SMTP",
        "CPU",
        "NoSQL",
        "MongoDB",
        "FTP"
      ]
      [ ConnectionGroup (Connection "CPU" "GPU" "SSD" "Motherboard") "Computer Hardware",
        ConnectionGroup (Connection "Linux" "Windows" "macOS" "Android") "Operating Systems",
        ConnectionGroup (Connection "HTTP" "TCP" "FTP" "SMTP") "Network Protocols",
        ConnectionGroup (Connection "SQL" "NoSQL" "MongoDB" "Redis") "Database Technologies"
      ],
    WordGrid
      [ "JavaScript",
        "Neural-Network",
        "Waterfall",
        "Encryption",
        "Firewall",
        "CSS",
        "Agile",
        "Blockchain",
        "Machine-Learning",
        "DevOps",
        "Deep-Learning",
        "React",
        "HTML",
        "Malware",
        "Scrum",
        "React",
        "Natural-Language-Processing"
      ]
      [ ConnectionGroup (Connection "Agile" "Scrum" "DevOps" "Waterfall") "Software Development Methodologies",
        ConnectionGroup (Connection "Encryption" "Firewall" "Malware" "Blockchain") "Cybersecurity Concepts",
        ConnectionGroup (Connection "Machine-Learning" "Neural-Network" "Deep-Learning" "Natural-Language-Processing") "Artificial Intelligence",
        ConnectionGroup (Connection "HTML" "CSS" "JavaScript" "React") "Web Development Technologies"
      ]
  ]
