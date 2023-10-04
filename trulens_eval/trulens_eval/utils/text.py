"""
Utilities for user-facing text generation.
"""

import logging

logger = logging.getLogger(__name__)

UNICODE_STOP = "🛑"
UNICODE_CHECK = "✅"
UNICODE_YIELD = "⚡"
UNICODE_HOURGLASS = "⏳"
UNICODE_CLOCK = "⏰"
UNICODE_SQUID = "🦑"
UNICODE_LOCK = "🔒"

def make_retab(tab):
    def retab(s):
        lines = s.split("\n")
        return tab + f"\n{tab}".join(lines)
    return retab
