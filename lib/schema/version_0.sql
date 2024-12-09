/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

CREATE TABLE IF NOT EXISTS sources (
    id INTEGER NOT NULL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    type INTEGER NOT NULL,
    auth_type INTEGER NOT NULL,
    base_url TEXT NOT NULL,
    username TEXT NOT NULL,
    password TEXT NOT NULL,
    failing BOOLEAN NOT NULL,
    last_seen INTEGER NOT NULL,
    prior_fetch INTEGER NOT NULL,
    last_fetch INTEGER NOT NULL,
    error_message TEXT NOT NULL,
    is_valid BOOLEAN,
    access_token TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS settings (
    id INTEGER NOT NULL PRIMARY KEY,
    key TEXT NOT NULL UNIQUE,
    value TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS alerts_cache (
    id INTEGER NOT NULL PRIMARY KEY,
    source INTEGER NOT NULL,
    kind INTEGER NOT NULL,
    hostname TEXT NOT NULL,
    service TEXT NOT NULL,
    message TEXT NOT NULL,
    url TEXT NOT NULL,
    age INTEGER NOT NULL,
    silenced INTEGER NOT NULL,
    downtime_scheduled INTEGER NOT NULL,
    active INTEGER NOT NULL
);
